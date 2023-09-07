library('tidyverse')
library(readxl)
library(broom)

# Import the data
casino_analysis <- read_excel("/home/xrander/Documents/Job Application/Megapixel/Statistics Assessment Data.xlsx")
casino_dt_2 <- read_excel("/home/xrander/Documents/Job Application/Megapixel/Tableau Assessment Data.xlsx")

# Dimension of the data
dim(casino_analysis) 
dim(casino_dt_2)

user_id <- casino_analysis[,1]

# Data Exploration
length(unique(casino_dt_2$UserID)) # There are 4418 unique users
length(unique(casino_analysis$UserID)) # All the users in this experiments are unique

# Extract data of users selected for the experiment from the population
exp_pple <- casino_dt_2 %>%
  filter(UserID %in% user_id$UserID) # Users selected for the experiment data

View(exp_pple)

# Summary of the data
summary(casino_analysis)

# Preview the data
head(casino_analysis, 10)

# Change the data type of brand and test_group
casino_analysis <- casino_analysis %>%
  mutate(Brand = factor(Brand),
         `Test Group` = factor(`Test Group`))

# Check for unique entries
duplicated(casino_analysis) 

# Check for missing values in all the columns of the dataframe
unique(is.na(casino_analysis))
unique(is.na(casino_dt_2$user))

# Check for Unique entries in the columns

#Estimate the number of users they have
length(unique(casino_analysis$UserID))

# Estimate the number of brands they have here
length(unique(casino_analysis$Brand)) 

# Estimate the number of number of test_group
length(unique(casino_analysis$`Test Group`))

# Conversion type expected
length(unique(casino_analysis$Converted))

# How players are grouped
table(casino_analysis$Converted)

table(casino_analysis$`Test Group`)

count(casino_analysis, wt = `Test Group`)

# Contingency table to see convert group and test group distribution
table(casino_analysis$`Test Group`, casino_analysis$Converted)

# We assume there is no control group and two features are being tested.

# Probability a user converts
casino_analysis %>%
  summarize(conversion_probability = sum(Converted)/length(Converted))

# Probability that group A users converted
casino_analysis %>%
  group_by(`Test Group`) %>%
  summarize(converted_number = sum(Converted),
            all_the_people = length(Converted)) %>%
  mutate(total = sum(converted_number, all_the_people))

# Chi-square
cas_chi_test <- chisq.test(casino_analysis$`Test Group`, casino_analysis$Converted, correct = F)
cas_chi_test$observed # observed counts
cas_chi_test$expected # expected
cas_chi_test$p.value # p_value
tidy(cas_chi_test)
glance(cas_chi_test)


augment(cas_chi_test)


casino_analysis %>%
  ggplot(aes(factor(Converted), fill = `Test Group`))+
  geom_bar(position = "dodge")

casino_analysis %>%
  filter(`Test Group` == "A") %>%
  summarize(sum =  sum(Converted),
            total = length(Converted)) %>%
  mutate(probability = sum/total)

casino_analysis %>%
  filter(`Test Group` == "B") %>%
  summarize(sum =  sum(Converted),
            total = length(Converted)) %>%
  mutate(probability = sum/total)

casino_analysis %>%
  group_by(`Test Group`) %>%
  summarize(sum = sum(Converted),
            total = length(Converted)) %>%
  mutate(probability = sum/sum(total))