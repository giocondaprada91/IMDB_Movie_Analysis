#IMDB Movies Dataset
#Load dataset 
library(readr)
dataset <- read.csv("C:/Users/Ali/STA 9750/STAOPR 9750 - Project/Dataset.csv")

#explore data
head(dataset)
summary(dataset)
str(dataset)
dim(dataset)
names(dataset)

#-----------------DATA CLEAN UP-------------------#

any_missing <- any(is.na(dataset)) #all rows in our dataset contain at least one missing value 
print(any_missing)
missing_values <- colSums(is.na(dataset))
print(missing_values)

# decided to remove rows with missing values in Meta_score and Gross columns
Dataset <- dataset[complete.cases(dataset$Meta_score, dataset$Gross), ]
#cleaned
missing_values1 <- colSums(is.na(cleaned_data_set))
print(missing_values1)

#we got 36 rows n/a in certificate which i think it is not a big deal 
 
#now, we will create a new column converting from minutes to decimals 
dataset$Runtime <- as.numeric(sub(" min", "", dataset$Runtime)) / 60
dataset$Runtime <- round(dataset$Runtime, 2)

#we wont need overview column 
cleaned_data_set$Overview <- NULL


#saving dataset
file_path <- "C:/Users/Ali/OneDrive/Desktop/Baruch/STA 9750/STAOPR 9750 - Project" 

#write the dataframe to a CSV file
write.csv(cleaned_data_set, file = file_path, row.names = FALSE)

#-----------------END OF DATA CLEAN UP-------------------#


#-----------------ADDITIONAL DATA CLEAN UP DO NOT USE-------------------#
#install.packages("magrittr")
library(magrittr)
df_view=dataset %>% group_by(Certificate) %>% summarise(avg_price=mean(Gross),Count=n())

character_IMDB_Rating <- as.character(dataset$IMDB_Rating)
dataset <- cbind(dataset, IMDB_RateChar = character_IMDB_Rating) #append to dataset

Numeric_Certificate <- factor(dataset$Certificate, levels = c("A", "UA", "U", "PG-13", "R", "PG", "G", "Passed", "TV-14", "16", "TV-MA", "Unrated", "GP", "Approved", "TV-PG", "U/A"), ordered = FALSE)

dataset <- cbind(dataset, CertNumeric = Numeric_Certificate)

cor(dataset$CertNumeric,dataset$Gross)

#-----------------END OF ADDITIONAL DATA CLEAN UP-------------------#

dataset$Gross <- as.numeric(gsub(",", "", dataset$Gross))
dataset$No_of_Votes <- as.numeric(gsub(",", "", dataset$No_of_Votes))


#-----------------ASSOCIATION ANALYSIS-------------------#

#y - Variable = Gross
#x1 = IMDB_Rating
#X2 = Meta_score
#X3 = Runtime_decimal
#X4 = Released_Year
#X5 = No_of_Votes

install.packages("vcd")
library(vcd)
update.packages("vcd")

install.packages("rcompanion")
library(rcompanion)

#Checking for highest correlation among variables.
cor_matrix(dataset) #correlation of all variables as a matrix.
all_correlations(dataset,sorted="strength") #sorts correlations from negative to positive.
all_correlations(dataset,interest='Gross',sorted="magnitude") #Strongest correlation to gross.


#Plotting variables to check which test for association is appropriate given our dataset
#see page 37 of lecture slides 6
plot(dataset$IMDB_Rating, dataset$Gross, main = "Scatterplot of Gross Revenue vs IMDB Rating", xlab = "IMDB_Rating", ylab = "Gross_Revenue")
plot(dataset$Gross~ dataset$Meta_score, main = "Scatterplot of Gross Revenue vs Meta Score", xlab = "Meta Score", ylab = "Gross_Revenue") 
plot(dataset$Gross ~ dataset$Runtime, main = "Scatterplot of Gross Revenue vs Runtime", xlab = "Runtime", ylab = "Gross_Revenue")
plot(dataset$Gross~ dataset$Released_Year, main = "Scatterplot of Gross Revenue vs Release Year", xlab = "Release Year", ylab = "Gross_Revenue")
plot(dataset$Gross~ dataset$No_of_Votes, main = "Scatterplot of Gross Revenue vs No. of Votes", xlab = "No. of Votes", ylab = "Gross_Revenue")

#-----Alternative correlation plot for visualization-----#
install.packages("corrplot")
library(corrplot)
subset_data <- dataset[, c(3, 7, 8, 14,15,32)]
correlation_matrix <- cor(subset_data) #correlation only among variables considered for analysis
corrplot(correlation_matrix, method = "color", type = "upper", order = "hclust", tl.cex = 0.7)
#----End of Alternative plot for visualization

#Conclusion: due to results from graph, there is heteroscedasticity, and many outliers,
#thus we can't use person's output of the function "associate(y~x)" to check for statistical significance.

#Solution: Spearman’s rank correlation converts the original values into their
#relative ranks and then finds the correlation of the ranks.

library(regclass)
associate(dataset$Gross~ dataset$IMDB_Rating , permutations = 500, seed=298)
associate(dataset$Gross~ dataset$Meta_score , permutations = 500, seed=298)
associate(dataset$Gross~ dataset$Runtime , permutations = 500, seed=298) 
associate(dataset$Gross~ dataset$Released_Year , permutations = 500, seed=298) 
associate(dataset$Gross~ dataset$No_of_Votes , permutations = 500, seed=298) 

#Conclusion: Spearman's p-values for all associations are less than 0.05, 
#thus although correlation isn't high, the relationships are statistically significant.


#--------REGRESSION ANALYSIS-----------#
library("ggplot2")

#1 Gross vs IMDB Rating
model1 = lm(Gross~IMDB_Rating,data=dataset)
plot(Gross~IMDB_Rating, data=dataset)
abline(model1, col = "red")
summary(model1)
anova(model1)


#2 Gross vs Meta_score
model2 = lm(Gross~Meta_score,data=dataset)
plot(Gross~Meta_score, data=dataset)
abline(model2, col = "red")
summary(model2)
anova(model2)

#3 Gross vs Runtime_decimal
model3 = lm(Gross~Runtime_decimal,data=dataset)
plot(Gross~Runtime_decimal, data=dataset)
abline(model3, col = "red")
summary(model3)
anova(model3)

#4 Gross vs Released_Year
model4 = lm(Gross~Released_Year,data=dataset)
plot(Gross~Released_Year, data=dataset)
abline(model4, col = "red")
summary(model4)
anova(model4)

#5) Gross vs No_of_Votes
model5 = lm(Gross~No_of_Votes,data=dataset)
plot(Gross~No_of_Votes, data=dataset)
abline(model5, col = "red")
summary(model5)
anova(model5)

#Multiple Regression Model
#Price vs Sqft-Living + Bedrooms + Bathrooms_new + Grade + New
model_multiple=lm(Gross ~ IMDB_Rating + Meta_score + Runtime_decimal + Released_Year + No_of_Votes, data = dataset)
summary(model_multiple)
anova(model_multiple)


#-----------------END OF REGRESSION ANALYSIS-------------------#


