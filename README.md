# cfmedip_pipeline

### MeDIP Pipeline
Rules, Outputs, Scripts

### Config file:
Include the fastq file location, metasheet location, run name
### Metasheet:
Cases, Controls, Reference_cases, reference_controls, type, class, batch 
Modify the get_targets(wildcards) depending on what rules you want to run
### Rules Trim, Align, Sort, Deduplicate: Align rule should be run as medium job. Make sure the time is atleast 48 hours in the cluster.json file
### Rule QC plots: Main Chromosome Unique Reads, Duplication plot, CpG Enrichment. 
### Rule Medips:
Output: medips.rds file, wig file (can be uploaded on IGV browser to view the read counts and compare)
medips.rds file important columns: chr, start, stop, rpkm (RPKM is a gene length normalized expression unit that is used for identifying the differentially expressed genes by comparing the RPKM values between different experimental conditions) 
### Rule Group Plots:
Plots to see if the samples cluster based on the groups
Check if the option to limit DMRs to reference DMRs is selected or no. 
Principal Component Analysis plot => PC1, PC2, PC3, PC4. Edit the group_plots script to include more PC component values. 
Batch information is also considered for the PC plots to check if there is batch effect. 
Hierarchical Clustering plot: Useful to see how the samples cluster together
### Rule Reference DMRs:
Input to this rule is the tissue Cancer and Healthy/ WBC samples that we use are reference groups. 
Aim is to find out the differentially methylated regions in these groups (reference classes vs reference controls) These DMRs are used to limit the regions in plasma samples while building the plasma classification model. 
Outputs:
reference_DMRs.bed: File has all the differentially methylated regions in the reference group with p value <0.05.
Important columns chr, start, stop, limma.adj.p.value, logFC
The file can be filtered by changing the p value and logFC cut offs (eg. p<0.05 and|logFC|>1, p<0.001 and |logFC| >2, p <10^-6 and |logFC|>3)
LogFC value: Log Fold change value is the log of ratio between two quantitates. Positive logFC value for a DMR means it is high in cases,
Negative LogFC regions are higher in controls.
Using the p value and logFC cut offs reference_DMRs.bed.case.up and reference_DMRs.bed.case.down files are created from reference_DMRs.bed
subset.sh s script can be used to create the subset of reference_DMRs.bed file using different cut offs
Volcano plots: logFC vs -logp plot: Blue regions are highly significant regions with p cut off 10^-6 and |logFC|>=3.
Case control Heatmap:  Heatmap to see how well the reference cases and controls cluster together and see the significant DMRs(more significant DMRs - darker regions in heatmap).

### Rule DMRs
Tissue Naive approach:
The input to the DMRs rule includes all the DMRs in the cancer and plasma samples. We do not limit the regions. (In config file make sure restrict_up, restrict_down= "None"). 
Tissue Limited approach:
We limit the input to the rule to regions that are significantly differentially methylated in the tissue (from reference DMRs step)
(restrict_up, restrict_down='' in config file) Apply different p value and logFC cut offs to the the refDMRs outputs and generate classification outputs for all the cases.
We have 2 classification models:- 
1: Leave One Out classification: here every model is built leaving one sample out for training the model and it is tested on the left-out sample. 
Accuracy is based on how accurately the remaining one sample is classified.
Note the AUC value, boxplots (generated in rule performance),  case.contro.diff.heatmap
The regions used in the classification model can be viewed in case.control.diff.bed. Check if any of the files are empty in the LOO output folder. The model will classify the samples even if these files are empty, but the results won’t be accurate. 
2: 80:20 split model: 100 iterations are performed. In every iteration 80% samples are used for training the classification model and the testing is done on the remaining 20%

### Rule rms (Relative Methylation score)
Select the most significant regions from reference_DMRS.bed.
Plot the normalized sum of reads boxplots in Up regions for cases and controls , Down regions for cases and controls, Portion score- (Case/ control score ratio)

### Rule Tissue derived:
Use the up DMRs(cases) and Down DMRs(controls) locations from the reference DMRs step.
Separately plot boxplots using rpkm values from medips file of cancer plasma and healthy plasma for Up and Down regions. 
We are expecting to see higher mean in the boxplots for cancer samples in the Up regions and lower mean in the Down regions compared to the Healthy samples boxplot.
 







