

## This function will generate random substrings from the larger reference sequence 
GenerateSimulatedReads <- function(refSequence, readLength, numberOfReadsToSimulate) {
  
  startPositions <- sample(x = c(1:(nchar(refSequence) - readLength)), size = numberOfReadsToSimulate, replace = T)
  endPositions   <- startPositions + readLength - 1
  sequenceVector    <- substring(as.character(refSequence), startPositions, endPositions)
  sequenceDataFrame     <- data.frame(startPositions, endPositions, sequenceVector, stringsAsFactors = FALSE)
  return(sequenceDataFrame)
}

# sample(x = c(10), size = 5, replace = T)
# substring(as.character("ATCGCGCATATACCGATCGT"), c(1,3,5), c(3,9,12))
# sequenceVector = substring(as.character("ATCGCGCATATACCGATCGT"), c(1,3,5), c(3,9,12))
# sequenceDataFrame     <- data.frame(c(1,3,5), c(3,9,12), sequenceVector, stringsAsFactors = FALSE)

## Methylate CpG dinucleoties in simulated reads with a given probability 
ConvertCG <- function(simulatedReads, methylationProbability) {

   flip <- rbinom(nrow(simulatedReads[grep("CG",simulatedReads$sequenceVector),]),1,1-methylationProbability)
   simulatedReads[,"flip"] <- 0
   simulatedReads[grep("CG",simulatedReads$sequenceVector),"flip"] <- flip
   simulatedReads[,"methylatedSeq"] <- simulatedReads$sequenceVector
   simulatedReads[simulatedReads$flip==1,]$methylatedSeq <- gsub("CG","TG",simulatedReads[simulatedReads$flip==1,]$sequenceVector)
   return(simulatedReads) # after bisulfite conversion of some CpGs to TpGs 
}

# simulatedReads[grep("CG",simulatedReads$sequenceVector),]
# sum(rbinom(30,1,0.4))
# gsub("CG","TG","CCCGAGAG")


## Re-align simulated reads back to the reference genome and calculate methylation ratios for CpGs 
AlignToReference <- function(meSimReads=methylatedSimulatedReads, refSequence, readLength, numberOfMismatches=1) {

   allKmers <- substring(refSequence, 1:(nchar(refSequence) - readLength + 1), readLength:nchar(refSequence))
   refCGpositions <- grep("CG",substring(refSequence,1:(nchar(refSequence)-1),2:nchar(refSequence)))
   coverageVector=replicate( 2, numeric(nchar(refSequence)))
   for(i in 1:nrow(methylatedSimulatedReads)) {
	 if (length(which(adist(allKmers, methylatedSimulatedReads$methylatedSeq[i])==0,))==1){
		for (j in meSimReads$startPositions[i]:meSimReads$endPositions[i]){
	       coverageVector[j,1]=coverageVector[j,1]+1
		}
	 }
   	 else if (length(which(adist(allKmers, methylatedSimulatedReads$methylatedSeq[i])<=numberOfMismatches,))==1){
		for (j in meSimReads$startPositions[i]:meSimReads$endPositions[i]){
	       coverageVector[j,2]=coverageVector[j,2]+1
		}
	 }
	}
	CpGs=coverageVector[refCGpositions,1]
	TpGs=coverageVector[refCGpositions,2]
	methylationSummary=cbind(refCGpositions, CpGs, TpGs, methylatedFraction=CpGs/(CpGs+TpGs))
	print (methylationSummary)
}

# refSequence = "CGGGATGAAGGCCCCCGA"
# allKmers = substring(refSequence, 1:(nchar(refSequence) - 5 + 1), 5:nchar(refSequence))
# refCGpositions = grep("CG",substring(refSequence,1:(nchar(refSequence)-1),2:nchar(refSequence)))
# which(adist(allKmers, "ATGAA")==0)
# which(adist(allKmers, "CCCTG")==1)


refSeq="CGGGATGAAGGCCCCCGAGCTCCCCGAGAGCAGCGTCAGGGCACGGATGC"
readLen=8 # number of base pairs for simulated reads
noOfSimReads=500 # number of reads to simulate 
methylationProbability=0.6 # on average 1 minus this fraction of reads will have C to T conversion

simulatedReads  <- GenerateSimulatedReads(refSequence=refSeq, readLength=readLen, numberOfReadsToSimulate=noOfSimReads)
methylatedSimulatedReads <- ConvertCG(simulatedReads, methylationProbability)
methylationSummary  <- AlignToReference(methylatedSimulatedReads, refSeq, readLen)

