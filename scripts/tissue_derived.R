args <- commandArgs( trailingOnly = TRUE )
filelist=args[1]
couplingset= args[2]
metasheet=args[5]
ref_dmrs= args[3]

run= args[4]
print("refDMRs")
print(args[3])
print(args[2])
suppressMessages(library(MEDIPS))
suppressMessages(library(ComplexHeatmap))
suppressMessages(library(RColorBrewer))
suppressMessages(library(annotatr))
suppressMessages(library(BSgenome.Hsapiens.UCSC.hg19))
suppressMessages(library(ggplot2))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(readxl))
suppressMessages(library(ggdendro))
suppressMessages(library(matrixStats))
suppressMessages(library(stringr))
suppressMessages(library(circlize))
suppressMessages(library(edgeR))
suppressMessages(library(DESeq2))

library(glmnet)
library(dplyr)
library(tidyr)

out= file.path(paste0(run, "/tissue_derived/"))
print(out)
dir.create(out)
#reading the reference datafarme. Filter the df based on p value or logFC if needed
chrs =  paste0("chr", c(1:22, "X", "Y"))
roi_df= read.table(ref_dmrs)
colnames(roi_df)= c("chr", "start", "stop", "CF", "rpkm", "logFC" ,"padj")

#read metasheet	
met=read.table(metasheet, header=T, sep=",", as.is=T)

met = subset(met, Class %in% c("case", "control"))

#match files to samples in metasheet
file=unlist(strsplit(filelist," "))
print(file)


SampleName = file %>% str_replace(".*/","") %>% str_replace(".medip.rds","")
met = merge(met, data.frame(cbind(SampleName, file)))
met$file = as.character(met$file)                                                                                                      
# load medips objects:
filelist1=  c(met[which(met$Class== "case",), "file"])
filelist2=  c(met[which(met$Class== "control",), "file"])


#Create an empty dataframe to read in plasma medips files and combine with locations from tissue DMRs
df_case <- data.frame(matrix(ncol = 12, nrow = 0))
colnames(df_case)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "rpkm_case", "rpkm_control", "logFC", "padj", "sample")

df_control <- data.frame(matrix(ncol = 12, nrow = 0))
colnames(df_control)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "rpkm_case", "rpkm_control", "logFC", "padj", "sample")
CS= readRDS(couplingset)

tissue_derived_df<- function(filenames= f,roi_df, df_comb= df, pcutoff= pcutoff, logcutoff= logcutoff, sample_type= sample_type){
	roi_df= roi_df[roi_df$padj<pcutoff,]
	roi_df= roi_df[abs(roi_df$logFC)>logcutoff,]
	for (file in filenames) {
	t=readRDS(file)
	window_size = window_size(t)
	no_chr_windows = ceiling(chr_lengths(t)/window_size(t))
	supersize_chr = cumsum(no_chr_windows)        
	GRanges.genome = MEDIPS.GenomicCoordinates(supersize_chr, no_chr_windows, chr_names(t), chr_lengths(t), window_size(t))
	base = data.frame(chr=as.vector(seqnames(GRanges.genome)), start=start(GRanges.genome), stop=end(GRanges.genome), CF=genome_CF(CS), stringsAsFactors=F)
	counts.medip = NULL
	rpkm.medip = NULL
	rms = NULL         
	counts.input = NULL
	rpkm.input = NULL
	counts.medip = cbind(counts.medip, MSet1=genome_count(t))
	rpkm.medip = cbind(rpkm.medip, round(((genome_count(t)*10^9)/(window_size*number_regions(t))), digits=2))
	ccObj = MEDIPS.calibrationCurve(MSet=t, CSet=CS, input=F)
	col.names.count = NULL
	col.names.rpkm = NULL
	col.names.rms = NULL

	col.names.count = c(col.names.count, paste(sample_name(t), ".counts", sep=""))
	col.names.rpkm = c(col.names.rpkm, paste(sample_name(t), ".rpkm", sep=""))
	counts.medip = data.frame(counts.medip)
	colnames(counts.medip) = col.names.count
	rpkm.medip =  data.frame(rpkm.medip)
	colnames(rpkm.medip) = col.names.rpkm
	df_merge=cbind(base,rpkm.medip)
	colum_names=colnames(df_merge)
	sample_name= colum_names[5]
	df_merge$sample_name= sample_name
	df_merge=df_merge[, c("chr", "start", "stop", "CF", sample_name, "sample_name")]
	#Merge the sample medips dataframe with the reference DMRS locations. ie limit to the regions in the reference datafrme(roi_df)
	df_mergeh=merge(df_merge, roi_df, by.x = c("chr", "start"), by.y=c("chr","start"))
	df_mergeh$sample=sample_type
	colnames(df_mergeh)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "rpkm_case", "rpkm_control", "logFC", "padj", "sample")
	df_comb=rbind(df_comb,df_mergeh)}
	return(df_comb)

}

#adjust the p values and logFC cut offs as needed
df_case1= tissue_derived_df(filelist1,roi_df, df_case, 0.001, 2, "case")
df_control1= tissue_derived_df(filelist2,roi_df, df_control, 0.001,2, "control")
df1= rbind(df_case1, df_control1)
print(wilcox.test(df1[df1$sample=="case", "rpkm"], df1[df1$sample=="control", "rpkm"]))

ggplot(df1, aes(x=sample_name, y= log2(rpkm+1))) + geom_boxplot()+  ggtitle('rpkm at Tissue derived DMRs, pcutoff= 0.001, logFC cut off= 2') + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
ggsave(paste0(out, "sample_wise_p_0.001_logFC2.png"))

ggplot(df1, aes(x=sample, y= log2(rpkm+1))) + geom_boxplot()+  ggtitle('rpkm at Tissue derived DMRs, pcutoff= 0.001, logFC cut off= 2')
ggsave(paste0(out, "p_0.001_logFC2.png"))


df_case2= tissue_derived_df(filelist1,roi_df, df_case, 0.000001, 3, "case")
df_control2= tissue_derived_df(filelist2,roi_df, df_control, 0.000001,3, "control")
df2= rbind(df_case2, df_control2)
print(wilcox.test(df2[df2$sample=="case", "rpkm"], df2[df2$sample=="control", "rpkm"]))
ggplot(df2, aes(x=sample, y= log2(rpkm+1))) + geom_boxplot()+  ggtitle('rpkm at Tissue derived DMRs, pcutoff= 10^-6, logFC cut off= 3')
ggsave(paste0(out, "p_10^6_logFC3.png"))











