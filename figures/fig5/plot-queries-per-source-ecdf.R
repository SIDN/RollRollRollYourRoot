#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/data/addrs-per-query-count'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig'
plot_path = '../../fig'

data_csv <- paste(data_path, '/', 'count-graph-cdf.csv', sep='')
df <- read_csv(data_csv)

p <- ggplot(df)
p <- p +geom_line(aes(x=sources, y=(cumul_source_count/max(df$cumul_source_count)), colour="CDF"))
p <- p +xlab('Number of queries')
p <- p +ylab('CDF of Source IPs)')
p <- p +scale_y_continuous(breaks=c(0.4,0.5,0.6,0.7,0.8,0.9,1.0))
p <- p +scale_x_log10(breaks=c(1,10,100,1000,10000,100000,1000000,10000000), labels=c('1','10','100','1000','10000', '100000', expression(10^6), expression(10^7)))
p <- p +theme(legend.position = "none")
p <- p +theme(axis.text.x = element_text(size=12))
p <- p +theme(axis.title.x = element_text(size=14))
p <- p +theme(axis.text.y = element_text(size=12))
p <- p +theme(axis.title.y = element_text(size=14))

plot_name <- paste(plot_path, '/', 'count-graph-cdf-log.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=6, dpi=300, units="cm")

