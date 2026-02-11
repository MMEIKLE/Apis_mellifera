#########################################
#  Computational Genomics Final Project #
#  Apis mellifera genetic tolerance to  #
#         clothianidin exposure         #
#                                       #
#           Makenzie Meikle             #
#########################################

#Installing & loading packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2") 
BiocManager::install("apeglm")
BiocManager::install("ashr")
install.packages("pheatmap") 
install.packages("kableExtra")
install.packages("ggpubr")

library(DESeq2)
library(pheatmap)
library(vsn)
library(ggplot2)
library(ggpubr)
library(kableExtra)
library(webshot2)
setwd("~/Desktop")

#Loading final count data conglomerated from hisat analysis
countsdata <- read.csv("Amel_Counts.csv", row.names = "gene_id")
coldata <- read.csv("Amel_Metadata.csv", row.names = "Sample")

#Sanity checks
all(colnames(countsdata) %in% rownames(coldata))
all(colnames(countsdata) == rownames(coldata))

#Building DESeq object
dds <- DESeqDataSetFromMatrix(
  countData = countsdata,
  colData = coldata,
  design = Treatment~Condition)


#Setting factor level
dds$Condition <- relevel(dds$Condition, ref = "Susceptible")

#Filtering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

#Running DESeq2
dds <- DESeq(dds)
res <- results(dds)

#Summarize results
summary(res)

#Subsetting by pvalue 0.05
res05 <- subset(res, padj < 0.05)
#Summarize subset results
resultSummary05 <- summary(res05)

#MA plots using 3 shrinkage LFC methods
plotMA(res)
resLFC <- lfcShrink(dds, coef=2, type="apeglm")
plotMA(resLFC, ylim=c(-3,3))
resNorm <- lfcShrink(dds, coef=2, type="normal")
FinalMA <- plotMA(resNorm, ylim=c(-3,3), main = "MA Plot of Normalized Counts")
resAsh <- lfcShrink(dds, coef=2, type="ashr")
plotMA(resAsh, ylim=c(-3,3))

#PCA analysis
vsd <- vst(dds, blind=FALSE)
PCAplot <- plotPCA(vsd, intgroup=c("Treatment", "Condition"), ntop = 500)
PCAplot + 
  ggtitle("Principal Component Analysis for Top 500 Samples") +
  guides(fill=guide_legend(title="Tissue Type + Susceptibility"))
  
meanSdPlot(assay(vsd))

#Trying volcano plot
diffData <- read.csv("ResultsSummary.csv")
diffData <- na.omit(diffData)
ggmaplot(resNorm, main = "Differentially Expressed Genes in Apis mellifera after treatment with sub-lethal dose of Clothianidin (p<0.05)",
         fdr = 0.05, fc = 2, size = 1,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         genenames = as.vector(rownames(resNorm)),
         legend = "top", top = 20,
         font.label = c("bold", 11), label.rectangle = TRUE,
         font.legend = "bold",
         font.main = "bold",
         ggtheme = ggplot2::theme_minimal())

#Heatmap
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:23]
df <- as.data.frame(colData(dds)[,c("Condition","Tissue")])
pheatmap(assay(vsd)[select,], 
         cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df,
         main = "Top 23 Differentially Expressed Genes In All Samples",
         display_numbers = T)

#Exporting results outputs
write.csv(as.data.frame(res), file = "ResultsSummary.csv")
write.csv(as.data.frame(res05), file = "ResultsSummary_Padj05.csv")
ddsCountsdata <- estimateSizeFactors(dds)
NormalizedCount <- counts(ddsCountsdata, normalized = T)
write.csv(NormalizedCount, file= "NormalizedCounts_TreatmentTolerance.csv", row.names = TRUE)

#Building pretty publishable tables
SRAdata <- read.csv("SRA_Accessions.csv")
Data05 <- read.csv("ResultsSummary_Padj05.csv", header = T, row.names = "Symbol")
Ordered_Data05 <- Data05[order(Data05$log2FoldChange, decreasing = T),]
SRAdata %>%
  kbl(caption = "Sample Characteristic Metadata & SRA Accession Numbers") %>%
  kable_classic(full_width = F, html_font = "Arial")

tbl<- Ordered_Data05 %>%
  kbl(caption = "Differentially Expressed Genes Significant at p<0.05") %>%
  kable_classic(full_width = F, html_font = "Arial")
save_kable(tbl, file = "DEGenes_Table.pdf")




