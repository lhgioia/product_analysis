#### get moisturizer data ####
library(stringr)

#### read product sheet from google sheets ####
productSheet <- read_sheet("1LVIoYIZDoDtc26z5JMHpv_7a34aqSZwdFsazG8_JlfY")

# calculate price per oz
productSheet$PRICE_PER_OZ <- productSheet$PRICE/productSheet$SIZE

# write.csv(productSheet, file = "/Users/lhg/Documents/dataface/moisturizer_analysis/data/productSheet.csv", row.names = F)

productList <- as.list(productSheet$INCIDECODER_URL)

# get ingredients for each product
ingredientLists <- list()
for(i in productList){
  productUrl <- paste("https://incidecoder.com/products/", i, sep="")
  productHtml <- read_html(productUrl)
  productData <- html_table(productHtml)[[1]]$`Ingredient name`
  ingredientLists[[i]] <- productData
}

# create vector of unique ingredients
ingredientsAll <- as.vector(do.call(c, ingredientLists, quote=T))
ingredientsUnique <- sort(unique(ingredientsAll))

# some summary counts
length(ingredientsUnique)
waterNames <- ingredientsUnique[grep(".*Water.*|Aqua", ingredientsUnique)]
## we have a problem with our water regex


# clean up ingredient names
source("/Users/lhg/Documents/dataface/moisturizer_analysis/src/ingredientRegex.R")
ingredientListsClean <- lapply(ingredientLists, 
                               str_replace_all, 
                               ingredientRegex)

# create vector of unique CLEANED ingredients
ingredientsCleanAll <- as.vector(do.call(c, ingredientListsClean, quote=T))
ingredientsCleanUnique <- sort(unique(ingredientsCleanAll))

# create data frame with ingredients as row names
ingredientDf <- data.frame(row.names = ingredientsCleanUnique)

# add index of each ingredient for each product to data frame
for(i in productList){
  ingredientDf[,i] <- as.numeric(match(row.names(ingredientDf), ingredientLists[[i]]))
}

ingredientDf[is.na(ingredientDf)] <- as.numeric(0)
ingredientDf[ingredientDf>0] <- as.numeric(1)

productDf <- as.data.frame(t(ingredientDf))

moisturizerData <- cbind(productSheet[,c("BRAND_NAME", "PRODUCT_NAME", "PRICE", "SIZE", "PRICE_PER_OZ", "STORE")],
                         productDf)

write.csv(moisturizerData, "/Users/lhg/Documents/dataface/moisturizer_analysis/data/moisturizer_data.csv", row.names = FALSE)
