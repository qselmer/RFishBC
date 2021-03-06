## Use this to create the RData files for the vignettes.
devtools::load_all(".")
setwd("C:/aaaWork/Programs/GitHub/RFishBC/vignettes/MeasureRadii")

## Process Scales
junk <- digitizeRadii("Scale_1.jpg",id="1",reading="DHO",edgeIsAnnulus=FALSE)
## choose Scale_1.jpg and set id to 1 ... use a different transect
digitizeRadii(reading="OHD",edgeIsAnnulus=FALSE,popID=TRUE)
## use yet another different transect
digitizeRadii("Scale_1.jpg",id="1",reading="ODH",edgeIsAnnulus=FALSE)
## a different fish
digitizeRadii("Scale_2.jpg",id="2",reading="DHO",edgeIsAnnulus=FALSE)
## choosing muliple files at once
### by selecting files initially
( imgs <- listFiles(ext=".jpg",other="Scale") )
( ids <- getID(imgs) )
digitizeRadii(imgs,id=ids,reading="MULT",edgeIsAnnulus=FALSE)
### by selecting files in a dialog box (select scale_1 and scale_2)
digitizeRadii(reading="MULT2",edgeIsAnnulus=FALSE)
### using selected files, but aborting the first one (to make sure it goes to the second)
digitizeRadii(imgs,id=ids,reading="ABORT",edgeIsAnnulus=FALSE)

### Treat this as if it is a spring-caught age-1 fish (only annulus is the edge)
junk2 <- digitizeRadii("Scale_3.jpg",id="3",reading="DHO",edgeIsAnnulus=TRUE)
### Treat this as if it is a fall-caught age-0 fish (no annulus to measure)
junk3 <- digitizeRadii("Scale_3.jpg",id="3",reading="TEMP",edgeIsAnnulus=FALSE)


#### Some tests of these functions
showDigitizedImage("Scale_1_DHO.rds")
showDigitizedImage(c("Scale_1_DHO.rds","Scale_1_OHD.rds","Scale_1_ODH.rds"))
showDigitizedImage()      # choose one file and then choose the three
showDigitizedImage(junk)  # uses the object created above
combineData("Scale_1_DHO.rds")
combineData(c("Scale_1_DHO.rds","Scale_1_OHD.rds","Scale_1_ODH.rds"))
combineData()             # choose one file and then choose the three
combineData(junk)         # uses the object created above
combineData(junk2)        # should show agecap=1 and 1 annulus


## Process the otolith
digitizeRadii("Oto140306.jpg",id="140306",reading="DHO",
              description="Used to demonstrate use of scale-bar.",
              scaleBar=TRUE,scaleBarLength=1,edgeIsAnnulus=TRUE,
              windowSize=12)
showDigitizedImage("Oto140306_DHO.rds",cex.ann=0.7)
showDigitizedImage("Oto140306_DHO.rds",annuliLabels=1:6)
showDigitizedImage("Oto140306_DHO.rds",annuliLabels=c(2,5))

## Open the otolith and just get the scaling factor from the scale-bar
## then use this to supply the scaling factor rather than use the scale-bar
## see if the results are basically the same as above
( SF <- findScalingFactor("Oto140306.jpg",knownLength=1,windowSize=12) )

digitizeRadii("Oto140306.jpg",id="140306",reading="OHD",
              description="Testing provided scaling factor.",
              scaleBar=FALSE,scalingFactor=SF,edgeIsAnnulus=TRUE,
              windowSize=12)


#### move these to a dead directory so that they don't appear in the vignettes
fns <- c(listFiles(".rds",other="MULT"),
         listFiles(".rds",other="TEMP"),
         listFiles(".rds",other="ABORT"))
file.copy(fns,"zzzTempRdsFiles/",overwrite=TRUE)
file.remove(fns)

#### Copy this to test suite so that an error is thrown if something changed
####    Need to do this because everything is interactive
file.copy(listFiles(".rds"),"../../tests/testthat/",overwrite=TRUE)
