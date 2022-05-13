args <- commandArgs( trailingOnly = TRUE )
filelist=args[1]
metasheet=args[2]
ref_dmrs= args[3]


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

source("scripts/limmamedips.R")

chrs =  paste0("chr", c(1:22, "X", "Y"))
roi_df= read.table(ref_dmrs, header= T)
#read metasheet	
met=read.table(metasheet, header=T, sep=",", as.is=T)
if(!all(c("SampleName", "Class", "Type") %in% colnames(met))) stop("check metasheet file for required columns")

#will batch info be included?
if("Batch" %in% colnames(met)) {show.batch=T}
else
{show.batch=F}


#match files to samples in metasheet
file=unlist(strsplit(filelist," "))
SampleName = file %>% str_replace(".*/","") %>% str_replace(".medip.rds","")

#Create an empty dataframe to read in plasma medips files and combine with locations from tissue DMRs
df_comb <- data.frame(matrix(ncol = 12, nrow = 0))
colnames(df_comb)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "rpkm_case", "rpkm_control", "logFC", "padj", "sample")
Filenames=all cancer


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
df_mergeh$sample="wbc"
colnames(df_mergeh)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "rpkm_case", "rpkm_control", "logFC", "padj", "sample")
#colnames(df_mergeh)=c("chr","start", "stop", "CF", "rpkm", "sample_name",  "end", "sample")
df_comb=rbind(df_comb,df_mergeh)


 }





