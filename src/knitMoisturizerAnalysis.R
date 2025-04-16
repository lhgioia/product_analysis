library(rmarkdown)

outputFileName <- paste("/Users/lhg/Documents/dataface/moisturizer_analysis/results/moisturizerAnalysis_", 
                        Sys.Date(), 
                        ".html", 
                        sep = "")

render("/Users/lhg/Documents/dataface/moisturizer_analysis/src/moisturizerAnalysis.Rmd", output_file = outputFileName)