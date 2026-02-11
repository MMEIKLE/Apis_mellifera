# Apis_mellifera
## Identification of differentially expressed genes in malpighian tubules of honeybees exposed to the neonicotinoid clothianidin
Analysis of Apis mellifera RNA-seq data from [Tsvetkov et al, 2023](https://doi.org/10.1016/j.isci.2023.106084). 

### Methods
​From original samples archived from Tsvetkov, et al., two patrilines were chosen from Colony 36. Two patrilines deemed “susceptible” to clothianidin and two deemed “tolerant”. Worker bees sampled from Patriline 1 and 8 were from the groups with the lowest survival rates and those from Patriline 11 and 24 were from the groups with the highest survival rates at LD50 dose of clothianidin (29 ppb). For the purposes of this analysis patrilines 1 and 8 are deemed “susceptible” to clothianidin and patrilines 11 and 24 are deemed “tolerant”. Worker bees were dissected and tissue from the brain, ventriculus and Malpighian tubules were isolated and sequenced. This analysis focused on the comparison of Malpighian tubule tissue in susceptible and tolerant lines as well as using a tolerant and susceptible brain tissue for comparative analysis to elucidate differentially expressed genes related to susceptibility to NNIs.
Raw fastq files for all samples were downloaded from the SRA archive (Leinonen, 2011), accessions available in table below.

<img width="468" height="145" alt="image" src="https://github.com/user-attachments/assets/29cbcde0-441c-46bc-8734-a89df4929985" />


​Raw reads were quality screened using Fastqc and low quality sequences, adapters and reads less than 75 bp were filtered out using Trimmomatic (Bolger, 2014). This analysis features using the updated Apis mellifera genome Amel_HAv3.1 (Kaskinova, 2021), closing some of the gaps and providing more complete annotations than genome used in previously published work. This genome was used with Hisat2 (Kim, 2019) to align reads to the reference genome. Reads were quantified and gene expression counts were obtained using HTSeq (Anders, 2015). Differential expression analysis was carried out using DESeq2 (Love, 2014) and statistics were calculated using R. All tables were created using the library kableExtra in R.
​Gene ontology analysis was performed on genes that had a false discovery rate (FDR) of <0.05 using ShinyGO (Ge, 2020).
