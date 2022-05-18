args <- commandArgs( trailingOnly = TRUE )
filelist=args[1]
metasheet=args[2]
rms_dir=args[3]

#--- tmp 

## including two early-timepoint samples:
#filelist="analysis/medips/GENP5274-1/GENP5274-1.medip.rds analysis/medips/GENP4908-1/GENP4908-1.medip.rds analysis/medips/RGENP728_2/RGENP728_2.medip.rds analysis/medips/GENP8187_P1/GENP8187_P1.medip.rds analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/RGENP1566_P1/RGENP1566_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP7951_P1/GENP7951_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/GENP8409_P1/GENP8409_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP7614_P1/GENP7614_P1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/RGENP531_1/RGENP531_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/GENP8256/GENP8256.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rds analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds analysis/medips/GENP5464/GENP5464.medip.rds analysis/medips/GENP7277/GENP7277.medip.rds"

# ctDNA>0 only, no localized or mHSPC
#filelist = "analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/RGENP1566_P1/RGENP1566_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP7951_P1/GENP7951_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/GENP8409_P1/GENP8409_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP7614_P1/GENP7614_P1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/RGENP531_1/RGENP531_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/GENP8256/GENP8256.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rds analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds"

#*** final list, with no exclusion based on ctDNA content ***
#filelist="analysis/medips/GENP5274-1/GENP5274-1.medip.rds analysis/medips/GENP4908-1/GENP4908-1.medip.rds analysis/medips/RGENP728_2/RGENP728_2.medip.rds analysis/medips/GENP8187_P1/GENP8187_P1.medip.rds analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/RGENP1566_P1/RGENP1566_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP7951_P1/GENP7951_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/GENP8409_P1/GENP8409_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP7614_P1/GENP7614_P1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/RGENP531_1/RGENP531_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/GENP8256/GENP8256.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rd analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/ analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds"

#this one has some of the reclassified samples added back
#filelist="analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP7559_P1/GENP7559_P1.medip.rds analysis/medips/GENP8187_P1/GENP8187_P1.medip.rds analysis/medips/GENP8237_P1/GENP8237_P1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP728_2/RGENP728_2.medip.rds analysis/medips/GENP7192_P1/GENP7192_P1.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/RGENP1566_P1/RGENP1566_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP7951_P1/GENP7951_P1.medip.rds analysis/medips/GENP8111_P1/GENP8111_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/GENP8409_P1/GENP8409_P1.medip.rds analysis/medips/RGENP2679_P1/RGENP2679_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/GENP7333_P1/GENP7333_P1.medip.rds analysis/medips/GENP7631_P1/GENP7631_P1.medip.rds analysis/medips/GENP7821_P1/GENP7821_P1.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP4908-1/GENP4908-1.medip.rds analysis/medips/GENP7614_P1/GENP7614_P1.medip.rds analysis/medips/GENP5274-1/GENP5274-1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/RGENP531_1/RGENP531_1.medip.rds analysis/medips/GENP4975-5/GENP4975-5.medip.rds analysis/medips/GENP6972_1/GENP6972_1.medip.rds analysis/medips/GENP2931-1/GENP2931-1.medip.rds analysis/medips/GENP7096_1/GENP7096_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/GENP8256/GENP8256.medip.rds analysis/medips/GENP8484/GENP8484.medip.rds analysis/medips/J17/J17.medip.rds analysis/medips/J18/J18.medip.rds analysis/medips/J19/J19.medip.rds analysis/medips/J20/J20.medip.rds analysis/medips/J21/J21.medip.rds analysis/medips/J22/J22.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rds analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds"



#this is the final one as of now 4/19/21:
#filelist="analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP7559_P1/GENP7559_P1.medip.rds analysis/medips/GENP8187_P1/GENP8187_P1.medip.rds analysis/medips/GENP8237_P1/GENP8237_P1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP728_2/RGENP728_2.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/RGENP1566_P1/RGENP1566_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP7951_P1/GENP7951_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/GENP8409_P1/GENP8409_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/GENP7333_P1/GENP7333_P1.medip.rds analysis/medips/GENP7631_P1/GENP7631_P1.medip.rds analysis/medips/GENP7821_P1/GENP7821_P1.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP4908-1/GENP4908-1.medip.rds analysis/medips/GENP7614_P1/GENP7614_P1.medip.rds analysis/medips/GENP5274-1/GENP5274-1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/RGENP531_1/RGENP531_1.medip.rds analysis/medips/GENP4975-5/GENP4975-5.medip.rds analysis/medips/GENP6972_1/GENP6972_1.medip.rds analysis/medips/GENP2931-1/GENP2931-1.medip.rds analysis/medips/GENP7096_1/GENP7096_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/GENP8256/GENP8256.medip.rds analysis/medips/GENP8484/GENP8484.medip.rds analysis/medips/J17/J17.medip.rds analysis/medips/J18/J18.medip.rds analysis/medips/J19/J19.medip.rds analysis/medips/J20/J20.medip.rds analysis/medips/J21/J21.medip.rds analysis/medips/J22/J22.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rds analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds"

#####filelist="analysis/medips/GENP6940_1/GENP6940_1.medip.rds analysis/medips/GENP8237_P1/GENP8237_P1.medip.rds analysis/medips/GENP8340_P1/GENP8340_P1.medip.rds analysis/medips/GENP2273-1/GENP2273-1.medip.rds analysis/medips/GENP5888-1/GENP5888-1.medip.rds analysis/medips/GENP6914_1/GENP6914_1.medip.rds analysis/medips/RGENP728_2/RGENP728_2.medip.rds analysis/medips/GENP7192_P1/GENP7192_P1.medip.rds analysis/medips/RGENP988_P1/RGENP988_P1.medip.rds analysis/medips/GENP7605_P1/GENP7605_P1.medip.rds analysis/medips/GENP8204_P1/GENP8204_P1.medip.rds analysis/medips/RGENP2679_P1/RGENP2679_P1.medip.rds analysis/medips/GENP2384-1/GENP2384-1.medip.rds analysis/medips/RGENP627_2/RGENP627_2.medip.rds analysis/medips/RGENP315-1/RGENP315-1.medip.rds analysis/medips/GENP3260-1/GENP3260-1.medip.rds analysis/medips/RGENP1484_P2/RGENP1484_P2.medip.rds analysis/medips/RGENP1984_P2/RGENP1984_P2.medip.rds analysis/medips/GENP7333_P1/GENP7333_P1.medip.rds analysis/medips/GENP7631_P1/GENP7631_P1.medip.rds analysis/medips/GENP7821_P1/GENP7821_P1.medip.rds analysis/medips/RGENP2044_P1/RGENP2044_P1.medip.rds analysis/medips/RGENP2082_P1/RGENP2082_P1.medip.rds analysis/medips/RGENP2251_P2/RGENP2251_P2.medip.rds analysis/medips/GENP2411-1/GENP2411-1.medip.rds analysis/medips/GENP4908-1/GENP4908-1.medip.rds analysis/medips/GENP7940_P1/GENP7940_P1.medip.rds analysis/medips/GENP7495_P1/GENP7495_P1.medip.rds analysis/medips/GENP4975-5/GENP4975-5.medip.rds analysis/medips/GENP6972_1/GENP6972_1.medip.rds analysis/medips/GENP2931-1/GENP2931-1.medip.rds analysis/medips/GENP7096_1/GENP7096_1.medip.rds analysis/medips/RGENP2421_P1/RGENP2421_P1.medip.rds analysis/medips/RGENP2438_P1/RGENP2438_P1.medip.rds analysis/medips/RGENP2318_P1/RGENP2318_P1.medip.rds analysis/medips/GENP7986_P1/GENP7986_P1.medip.rds analysis/medips/J17/J17.medip.rds analysis/medips/J18/J18.medip.rds analysis/medips/J19/J19.medip.rds analysis/medips/J20/J20.medip.rds analysis/medips/J21/J21.medip.rds analysis/medips/J22/J22.medip.rds analysis/medips/J23/J23.medip.rds analysis/medips/J24/J24.medip.rds analysis/medips/J25/J25.medip.rds analysis/medips/J26/J26.medip.rds analysis/medips/J28/J28.medip.rds analysis/medips/J29/J29.medip.rds analysis/medips/J30/J30.medip.rds analysis/medips/J31/J31.medip.rds analysis/medips/J32/J32.medip.rds analysis/medips/LUNGIP01/LUNGIP01.medip.rds analysis/medips/LUNGIP02/LUNGIP02.medip.rds analysis/medips/LUNGIP03/LUNGIP03.medip.rds analysis/medips/LUNGIP04/LUNGIP04.medip.rds analysis/medips/LUNGIP05/LUNGIP05.medip.rds analysis/medips/LUNGIP06/LUNGIP06.medip.rds analysis/medips/LUNGIP07/LUNGIP07.medip.rds analysis/medips/LUNGIP08/LUNGIP08.medip.rds"
#metasheet="metasheet.csv"
#rms_dir="analysis/dmrs/lucap_cf_nepc_vs_prad_train_test_final/rms"
#--- end tmp

#ctdna.file="misc/ctDNA.tsv"

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
library(plotROC)

source("scripts/limmamedips.R")

#TODO: review which libraries can be removed

meth.file=file.path(rms_dir, "medip.rds")
rms.file.up=file.path(rms_dir, "rms.up.rds") #file will have relative methylation score for windows that are UP in reference cases
restrict.up=file.path(rms_dir, "reference_up_filtered.bed")
rms.file.down=file.path(rms_dir, "rms.down.rds") #file will have relative methylation score for windows that are DOWN in reference cases
restrict.down=file.path(rms_dir, "reference_down_filtered.bed")
rms.thresh=0.2 #relative methylation score must be greater than this to be counted as methylated

chrs =  paste0("chr", c(1:22, "X", "Y", "M"))
        
#read metasheet	
met=read.table(metasheet, header=T, sep=",", as.is=T)
if(!all(c("SampleName", "Class", "Type") %in% colnames(met))) stop("check metasheet file for required columns")

#will batch info be included?
if("Batch" %in% colnames(met)) {
show.batch=T} else {
show.batch=F
}


#match files to samples in metasheet
file=unlist(strsplit(filelist," "))
SampleName = file %>% str_replace(".*/","") %>% str_replace(".medip.rds","") 
                                                                                                                          
message("excluding the following samples that are in the config file but not the metasheet file (if any):")       
message(SampleName[!SampleName %in% met$SampleName])  
        
met = merge(met, data.frame(cbind(SampleName, file)))                                                                                  
met$file = as.character(met$file)                                                                                                      
# load medips objects:                                                                                           
message("reading in medips files") #
message(met$file) #tmp

if(!file.exists(meth.file)) {
obj1 <- lapply(met$file, readRDS)                                                                                


# the coupling set contains counts of CG for each window, can be used for normalization
if(file.exists("analysis/couplingset/couplingset.rds")) {
  CS = readRDS("analysis/couplingset/couplingset.rds")
} else {
  CS = MEDIPS.couplingVector(pattern = "CG", refObj = obj[[1]]) 
}

meth = MEDIPS.meth(obj1, CSet = CS, chr = chrs, MeDIP = T) 
	saveRDS(meth, file = meth.file)
} else {
	meth=readRDS(meth.file)
}

meth.all = meth[,grepl("bam.rms", colnames(meth))]

rms.tot=colSums(meth.all)
#rms.tot.binary=colSums(meth.all>rms.thresh)

# restrict to sites that are UP in reference cases
sites_up=import(restrict.up, format="BED") 
incl.up = rep(TRUE, nrow(meth))
incl.up = incl.up & (makeGRangesFromDataFrame(meth) %over% sites_up) 	

meth.target.up = meth[incl.up,grepl("bam.rms", colnames(meth))]
colnames(meth.target.up) = str_replace(colnames(meth.target.up),".dedup.bam.rms","") %>% str_replace("\\.","-")
saveRDS(meth.target.up, rms.file.up)

# restrict to sites that are DOWN in reference cases
sites_down=import(restrict.down, format="BED")
incl.down = rep(TRUE, nrow(meth))
incl.down = incl.down & (makeGRangesFromDataFrame(meth) %over% sites_down)

meth.target.down = meth[incl.down,grepl("bam.rms", colnames(meth))]
colnames(meth.target.down) = str_replace(colnames(meth.target.down),".dedup.bam.rms","") %>% str_replace("\\.","-")
saveRDS(meth.target.down, rms.file.down)

score.up = colSums(meth.target.up)/rms.tot
score.down = colSums(meth.target.down)/rms.tot
#score.binary = colSums(meth.target.up>rms.thresh)/rms.tot.binary

df = data.frame(case_score = score.up, control_score = score.down, SampleName=names(score.up))
df = merge(df, met, by="SampleName")
df$Type=factor(df$Class, levels=c("case","control"))

df$portion=log((df$case_score/sum(incl.up))/(df$control_score/sum(incl.down)),2)

#normalize portion score to the median for the healthy controls:
#med_portion = median(df$portion[df$Type=="HEALTHY"])
#df$portion = df$portion - med_portion

#annotate with ctDNA content
#ctdna=read.table(ctdna.file, sep="\t", head=T)

#TODO: remove one of these:
#df=merge(df,ctdna, by="SampleName", all.x=T)

#subset to remove samples with 0 ctDNA

#df = subset(df, (is.na(ctDNA_estimate) & Type=="HEALTHY") | (!is.na(ctDNA_estimate) & ctDNA_estimate > 0)) #this includes healthy samples, but removes any cancer samples where ctDNA = 0 per ichorCNA

#df = subset(df, (is.na(ctDNA_estimate) & Type=="HEALTHY") | (!is.na(ctDNA_estimate) & ctDNA_estimate >= 0.05)) #this includes healthy samples, but removes any cancer samples where ctDNA <0.05 0 per ichorCNA

#cols <- c("PRAD" = "blue", "NEPC" = "red")
cols <- c("case" = "red", "control" = "blue")

ggplot(df, aes(y=case_score, x=Type)) + geom_boxplot(outlier.shape = NA) + geom_jitter(aes(color=Type), height = 0) + theme_classic() + scale_color_manual(values = cols)
ggsave(file.path(rms_dir, "rms_score_type_case.pdf"), height=3, width=3)

if(show.batch) {
  ggplot(df, aes(y=case_score, x=Type)) + geom_boxplot(outlier.shape = NA) + geom_jitter(aes(color=as.factor(Batch)), height = 0) + theme_classic()
  ggsave(file.path(rms_dir, "rms_score_type_case_batch.pdf"), height=3, width=3)
}

ggplot(df, aes(y=control_score, x=Type)) + geom_boxplot(outlier.shape = NA) + geom_jitter(aes(color=Type),height = 0) + theme_classic() + scale_color_manual(values = cols)
ggsave(file.path(rms_dir, "rms_score_type_control.pdf"), height=3, width=3)

ggplot(df, aes(y=portion, x=Type)) + geom_boxplot(outlier.shape = NA) + geom_jitter(aes(color=Type),height = 0) + theme_classic() + scale_color_manual(values = cols)
ggsave(file.path(rms_dir, "rms_score_type_ratio.pdf"), height=3, width=3)

#write table with results
write.table(df, file = file.path(rms_dir, "rms_scores.txt"), quote=F, sep="\t", row.names=F)


# plot auc for NEPC score for calssifying presence of ANY NE features:
aucsamples = subset(df, Type=="case" | Type=="control")

curves <-  calculate_roc(D=as.numeric(aucsamples$Type=="case"), M=aucsamples$case_score, ci = FALSE)
auc_plot <- ggplot() +
  geom_line(data = curves, aes(x=FPF, y = TPF)) +
  theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  geom_roc(data=aucsamples, aes(d = as.numeric(aucsamples$Type=="case"), m = case_score), labels = FALSE, color="darkgray")

ggsave(auc_plot, file = file.path(rms_dir, "auc_curve_case.pdf"),
  width = 3, height = 3)

message("classification AUC for NEPC score, ground truth is ANY NE features: ", calc_auc(auc_plot)$AUC)

curves <-  calculate_roc(D=as.numeric(aucsamples$Type=="control"), M=aucsamples$portion, ci = FALSE)
auc_plot <- ggplot() +
  geom_line(data = curves, aes(x=FPF, y = TPF)) +
  theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  geom_roc(data=aucsamples, aes(d = as.numeric(aucsamples$Type=="control"), m = portion), labels = FALSE, color="darkgray")

ggsave(auc_plot, file = file.path(rms_dir, "auc_curve_portion.pdf"),
  width = 3, height = 3)

message("classification AUC for case/control score ratio, ground truth is ANY NE features: ", calc_auc(auc_plot)$AUC)





