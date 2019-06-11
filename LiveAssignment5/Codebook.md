#Live Assignment 5 Codebook

###Files:
Codebook.md - Markdown file containing details of this analysis  
girlNames.csv - CSV file containing 10 most popular girls names. Output of LiveAssignment5.Rmd  
LiveAssignment5.html - HTML output of LiveAssignment5.Rmd  
LiveAssignment5.Rmd - R Markdown file containing analysis of popular names  
yob2015.txt - Comma Separated text file containing popular names for 2015  
yob2016.txt - Semi-Colon separated text file containing popular names for 2016  

###Variables (Source)
firstName - popular first name, used in both yob2015.txt and yob2016.txt  
gender - Indicates Male or Female name (M,F) in both yob2015.txt and yob2016.txt  
amountOfChildren - count of children using a specific name in both yob2015.txt and yob2016.txt

###Variables (Derived in LiveAssignment5.Rmd)  
df - original data frame containing the yob2016 data  
rowNum - index of name with typo  
y2016 - cleaned data frame containing yob2016 data  
y2015 - cleaned data frame containing yob2015 data  
final - data frame containing the inner join of y2016 and y2015  
Total - column added to final which is the sum of the amount of children with a specific name for both 2015 and 2016  
girlNames - data frame containing the combined top 10 girls names from both 2015 and 2016.  

###Variables (girlNames.csv)  
firstName - popular girls' first name  
Total - total children with that name from 2016 and 2015