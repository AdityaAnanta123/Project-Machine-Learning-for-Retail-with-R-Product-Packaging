#1 Statictic Top 10

##Import Library Arules for Association Rules
library(arules)

##read file tsv using read.transactions
transaction <- read.transactions(file = "transaksi_dqlab_retail.tsv", format = "single", sep = "\t", cols = c(1,2), skip = 1)

##sorting top 10 data using sort
transaction_top_10 <- sort(itemFrequency(transaction, type = "absolute"),decreasing = TRUE)[1:10]

##convert variable transaction_top_10 into data frame transaction
transaction <- data.frame("Nama Produk"= names(transaction_top_10),"Jumlah"=transaction_top_10, row.names = NULL)

##save as .txt file
write.csv(transaction, file="top10_item_retail.txt", sep = ",")   

#2 Startistic Bottom 10

##Import Library Arules for Association Rules
library(arules)

##read file tsv using read.transactions
transaction <- read.transactions(file = "transaksi_dqlab_retail.tsv", format = "single", sep = "\t", cols = c(1,2), skip = 1)

##sorting top 10 data using sort
transaction_bottom_10 <- sort(itemFrequency(transaction, type = "absolute"),decreasing = FALSE)[1:10]

##convert variable transaction_bottom_10 into data frame transaction
transaction <- data.frame("Nama Produk"= names(transaction_bottom_10),"Jumlah"=transaction_bottom_10, row.names = NULL)

##save as .txt file
write.csv(transaction, file="bottom10_item_retail.txt", sep = ",")

#3 Combination Top Product
##Import Library Arules for Association Rules
library(arules)

##read file tsv using read.transactions
transaction <- read.transactions(file = "transaksi_dqlab_retail.tsv", format = "single", sep = "\t", cols = c(1,2), skip = 1)

##make model apriori with support min 10 for all transaction, confident min 50%, min combination item 2 and max combination item 3
combination <- apriori(transaction, parameter = list(supp = 10/length(transaction),confidence = 0.5, minlen = 2, maxlen = 3))

##sorting top 10 data by lift
combination <- sort(combination,by= "lift", decreasing = TRUE)[1:10]

##convert variable combination to .txt file
write(combination, file = "kombinasi_retail.txt")

#4 Combination Top Product with Slow Moving
##Import Library Arules for Association Rules
library(arules)

##read file tsv using read.transactions
transaction <- read.transactions(file = "transaksi_dqlab_retail.tsv", format = "single", sep = "\t", cols = c(1,2), skip = 1)

##make model apriori with support min 10 for all transaction, confident min 10%, min combination item 2 and max combination item 3
combination <- apriori(transaction, parameter = list(supp = 10/length(transaction),confidence = 0.1, minlen = 2, maxlen = 3))

##Make a variable combination_1 for lift > 1 & right hand shake in Tas Makeup
combination_1 <- subset(combination, lift > 1 & rhs %in% "Tas Makeup")

##Sorting data in variable combination_1 by lift and using top 3 data
combination_1 <- head(sort(combination_1, by = "lift", decreasing = TRUE),n=3)

##Make a variable combination_2 for lift > 1 & right hand shake in Baju Renang Pria Anak-anak
combination_2 <- subset(combination, lift > 1 & rhs %in% "Baju Renang Pria Anak-anak")

##Sorting data in variable combination_2 by lift and using top 3 data
combination_2 <- head(sort(combination_2, by = "lift", decreasing = TRUE),n=3)

##merge variable combination_1 & combination_2 using vertor(function c)
combination <- c(combination_1,combination_2)

inspect(combination)

##convert variable combination to .txt file
write(combination, file = "kombinasi_retail_slow_moving.txt")
