if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
NEISCC <- merge(NEI, SCC, by="SCC")
library(ggplot2)
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
table(coalMatches)
subsetNEISCC <- NEISCC[coalMatches, ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)
png("plot4.png", width=640, height=480)
ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))+ 
  geom_bar(stat="identity",fill="#FF9999", colour="black") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
dev.off()