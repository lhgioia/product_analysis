moisturizer ingredient analysis
================

### Introduction

I’m pretty sure skincare companies are just making stuff up. They aren’t
doing research. They aren’t inventing anything. They are only focused on
getting people to buy their products. So they put all of their effort
and money into marketing and copying the things that other companies
have successfully marketed.

I wanted to get a sense of what’s actually in these products, and I
think just reading the ingredient lists makes it hard to tell what is
going on. I know enough chemistry to understand what the ingredient
names mean. I know data analysis. So I started by downloading a bunch of
ingredient lists so I could compare them. This research has been a
roller coaster with many unexpected roadblocks. So buckle up and get
ready to jump some hurdles with me.

### Getting the data

First, we have to get some data. I got the best-seller results from
[Target](https://www.target.com/) and
[Sephora](https://www.sephora.com/), and created a [google
sheet](https://docs.google.com/spreadsheets/d/e/2PACX-1vS4wAroj1XvB4aiuOg97IdS6xNd2x0wsylwXOYZZlCAysx3n5SA9Fi3IcLrbWGe_e7cuhzW2_fOl8qj/pubhtml)
with each product’s brand name, product name, price, size, and product
link on [INCIDecoder](https://www.incidecoder.com), which is where we
will be scraping the ingredient lists. Sadly, the Target and Sephora
websites are difficult to scrape. I had to gather all of the data by
hand :( I might try to implement that in the future with
[RSelenium](https://docs.ropensci.org/RSelenium/).

The google sheet is imported using the [googlesheets4 R
package](https://googlesheets4.tidyverse.org/). Here are the top few
entries:

``` r
library(googlesheets4)
productSheet <- read_sheet("1LVIoYIZDoDtc26z5JMHpv_7a34aqSZwdFsazG8_JlfY")
kable(head(productSheet, n = 5L))
```

| BRAND_NAME       | PRODUCT_NAME                  | PRICE | SIZE | STORE   | INCIDECODER_URL                        |
|:-----------------|:------------------------------|------:|-----:|:--------|:---------------------------------------|
| CeraVe           | PM Facial Moisturizing Lotion | 15.59 |  3.0 | target  | cerave-pm-facial-moisturizing-lotion   |
| Olay             | Super Cream with Sunscreen    | 36.99 |  1.7 | target  | olay-super-cream-with-sunscreen-spf-30 |
| Vanicream        | Moisturizing Lotion           | 14.29 | 16.0 | target  | vanicream-moisturizing-lotion          |
| First Aid Beauty | Ultra Repair Cream            | 48.00 |  8.0 | sephora | first-aid-beauty-ultra-repair-cream    |
| Tatcha           | The Dewy Skin Cream           | 89.00 |  2.5 | sephora | tatcha-the-dewy-skin-cream             |
