#!/usr/bin/env Rscript

require(readr)
require(ggplot2)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/data/root_canary/processed'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig'
plot_path = '../../../fig'

data_csv <- paste(data_path, '/', 'key_new_ttl.csv', sep='')
df <- read_csv(data_csv, col_names=FALSE)
names(df) <- c('ttl')

p <- ggplot()
p <- p +geom_segment(aes(x=10800, xend=10800, y=0, yend=1), size=0.75, linetype='dotted')
p <- p +geom_segment(aes(x=86400, xend=86400, y=0, yend=1), size=0.75, linetype='dashed')
p <- p +geom_segment(aes(x=172800, xend=172800, y=0, yend=1), size=0.75, linetype='dotdash')
p <- p +stat_ecdf(data=df,aes(ttl, colour="CDF"), geom = "line", pad=FALSE)
p <- p +xlab('TTL')
p <- p +ylab('ECDF of TTL')
p <- p +scale_x_continuous(breaks=c(0,10800,86400,172800), labels=c('','10800','86400','172800'), minor_breaks = c())
p <- p +geom_segment(aes(x=21600, xend=11800, y=0.825, yend=0.825), size=0.5, arrow=arrow(length = unit('0.25', 'cm')))
p <- p +annotate('text', x=22600, y=0.825, hjust=0, vjust=0.5, label='TTL capped\nat 10800s\n(3 hours)', size=6, lineheight=0.85)
p <- p +geom_segment(aes(x=86400+10800, xend=87400, y=0.825, yend=0.825), size=0.5, arrow=arrow(length = unit('0.25', 'cm')))
p <- p +annotate('text', x=86400+11800, y=0.825, hjust=0, vjust=0.5, label='TTL capped\nat 86400s\n(1 day)', size=6, lineheight=0.85)
p <- p +theme(legend.position = "none")
p <- p +theme(axis.text.x = element_text(size=18))
p <- p +theme(axis.title.x = element_text(size=18))
p <- p +theme(axis.text.y = element_text(size=18))
p <- p +theme(axis.title.y = element_text(size=18))

p

plot_name <- paste(plot_path, '/', 'cdf_ttls_new_key.pdf', sep='')

ggsave(plot_name, p, device="pdf", width=16, height=10, dpi=300, units="cm")

