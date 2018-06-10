library("ggplot2")

POLICIES = c('ClockLRU',  'Random', 'LRU')


my_theme <- theme(axis.text.x=element_text(angle=30, hjust=1, size=5))

plotData <- data.frame()

for (policy in POLICIES) {
    file = paste(policy, '.csv', sep='')
    data <- read.csv(file)
    data$Policy = policy
    plotData <- rbind(plotData, data)

    print(summary(cbind(data$CPI, data$LLC.Misses, data$LLC.Miss.Rate)))
}

# print(as.character(plotData$Trace.Name))
# plotData$Trace.Name <- sapply(strsplit(as.character(plotData$Trace.Name), '.', fixed=TRUE), function (a) {a[2]})
#

p <- ggplot(plotData, aes(x=Trace.Name, y=CPI, fill=Policy)) + geom_bar(stat='identity', position='dodge') + labs(x="traces", y="CPI", title="Cycles Per Instruction") + scale_fill_manual(values=c('red','blue','green')) + my_theme
p


p <- ggplot(plotData, aes(x=Trace.Name, y=LLC.Misses, fill=Policy)) +
    geom_bar(stat='identity', position='dodge') +
    labs(x="traces", y="misses", title="Last Level Cache Misses") + scale_fill_manual(values=c('red','blue','green')) +
    my_theme
p

p <- ggplot(plotData, aes(x=Trace.Name, y=LLC.Miss.Rate, fill=Policy)) +
    geom_bar(stat='identity', position='dodge') +
    labs(x="traces", y="miss rate (%)", title="Last Level Cache Miss Rate") + scale_fill_manual(values=c('red','blue','green')) +
    my_theme
p
