
# Course Project 2 - Plot 3
# Assignment at
# https://class.coursera.org/exdata-002/human_grading/view/courses/972082/assessments/4/submissions
# Data file from
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# See download_data.R

# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(plyr)
library(ggplot2)

# Read the data file
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

BaltimoreCity <- subset(NEI, fips == "24510")

typePM25ByYear <- ddply(BaltimoreCity, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25ByYear)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=typePM25ByYear, color=type, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
