#' ----
#' title: " A script for aligning BM Sicily exhibition coins with Nomisma mints"
#' author: "Daniel Pett"
#' date: "12/04/2016"
#' output: csv_document
#' ----
#' The SPARQL query used:
#' 
#' 
#'
setwd("~/Documents/research/sicilyCoins") #MacOSX

# Create CSV directory if does not exist
if (!file.exists('csv')){
  dir.create('csv')
}

nomisma <- read.csv("http://nomisma.org/query?query=PREFIX+rdf%3A%09%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0D%0APREFIX+bio%3A%09%3Chttp%3A%2F%2Fpurl.org%2Fvocab%2Fbio%2F0.1%2F%3E%0D%0APREFIX+dcmitype%3A%09%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Fdcmitype%2F%3E%0D%0APREFIX+dcterms%3A%09%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Fterms%2F%3E%0D%0APREFIX+foaf%3A%09%3Chttp%3A%2F%2Fxmlns.com%2Ffoaf%2F0.1%2F%3E%0D%0APREFIX+geo%3A%09%3Chttp%3A%2F%2Fwww.w3.org%2F2003%2F01%2Fgeo%2Fwgs84_pos%23%3E%0D%0APREFIX+nm%3A%09%3Chttp%3A%2F%2Fnomisma.org%2Fid%2F%3E%0D%0APREFIX+nmo%3A%09%3Chttp%3A%2F%2Fnomisma.org%2Fontology%23%3E%0D%0APREFIX+org%3A%09%3Chttp%3A%2F%2Fwww.w3.org%2Fns%2Forg%23%3E%0D%0APREFIX+osgeo%3A%09%3Chttp%3A%2F%2Fdata.ordnancesurvey.co.uk%2Fontology%2Fgeometry%2F%3E%0D%0APREFIX+rdac%3A%09%3Chttp%3A%2F%2Fwww.rdaregistry.info%2FElements%2Fc%2F%3E%0D%0APREFIX+skos%3A%09%3Chttp%3A%2F%2Fwww.w3.org%2F2004%2F02%2Fskos%2Fcore%23%3E%0D%0APREFIX+spatial%3A+%3Chttp%3A%2F%2Fjena.apache.org%2Fspatial%23%3E%0D%0APREFIX+un%3A%09%3Chttp%3A%2F%2Fwww.owl-ontologies.com%2FOntology1181490123.owl%23%3E%0D%0APREFIX+xsd%3A%09%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0D%0A%0D%0ASELECT+*+WHERE+%7B%0D%0A%3Floc+spatial%3Anearby+%2837+14+500+%27km%27%29+%3B%0D%0A++++++++geo%3Alat+%3Flat+%3B%0D%0A++++++++geo%3Along+%3Flong+.%0D%0A+++%3Fmint+geo%3Alocation+%3Floc+%3B%0D%0A+++++++++skos%3AprefLabel+%3Flabel+%3B%0D%0A+++++++++a+nmo%3AMint%0D%0A++FILTER+langMatches+%28lang%28%3Flabel%29%2C+%27en%27%29%0D%0A+++++++++%7D%0D%0ALIMIT+1000&output=csv")
names(nomisma) <- c('location', 'lat', 'long', 'nomismaMint', 'label')
bmCoins <- read.csv('csv/coinsBM.csv')
final <- merge(nomisma, bmCoins, by='nomismaMint', all=FALSE)
drop <- c("location", "label", "metal")
final <- final[,!(names(final) %in% drop)]
final <- final[,c('mint', 'description', 'metalName', 'regNumber', 'PRN', 'lat', 'long', 'imageUrl' )]
write.csv(final, file="csv/matchedNomismaBM.csv",row.names=FALSE)
# Now convert data to geojson see conversion.txt