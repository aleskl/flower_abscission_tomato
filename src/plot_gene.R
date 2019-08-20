# simple R script for plotting data for one gene

# get command arguments
# examples: Rscript plot_gene.R ein3
cmdArgs = commandArgs(trailingOnly=TRUE)

df = read.csv('/home/marko/phd/flower_abscission_tomato/data/timeseries_flower_qpcr.csv')
colnames(df)[1] = 'Time'

agg = aggregate(df[,toupper(cmdArgs[1])], list(df$Time, df$Zone), mean)
P = agg[agg$Group.2 == 'P',]$x
D = agg[agg$Group.2 == 'D',]$x

png(filename = paste0('plot_', cmdArgs[1], '.png'), width = 600, height = 400)
plot(x = 1:length(P),
     y = P,
     type = 'l',
     col = 'blue',
     xlab = 'time after induction',
     ylab = 'rel. expression',
     ylim = c(min(agg$x), max(agg$x)),
     xaxt = 'n')
lines(x = 1:length(D), y = D, col = 'red')
axis(side = 1, at = 1:length(P), labels = c('0', '2', '4', '6', '8', '10', '12'))
dev.off()
