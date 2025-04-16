library(rmarkdown)
library(here)

outputFileName <- paste0(here(), "/results/moisturizerAnalysis-", Sys.Date(), ".html")

render(paste0(here(), "/src/moisturizerAnalysis.Rmd"), output_file = outputFileName)
