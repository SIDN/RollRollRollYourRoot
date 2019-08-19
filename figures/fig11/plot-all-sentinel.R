#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/dnsthought'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/dnsthought'
plot_path = '.'

data_csv <- paste(data_path, '/', 'dnsthought_sentinel_data.csv', sep='')
df <- read_csv(data_csv)

p <- ggplot(df, aes(x=as.Date(date)))
p <- p +geom_line(aes(y=has_ta_19036, colour="KSK-2010"))
p <- p +geom_line(aes(y=has_ta_20326, colour="KSK-2017"))
p <- p +ylab('Number of resolvers')
p <- p +theme(axis.title.x = element_blank())
p <- p +theme(axis.text.x = element_text(size=12,hjust=1, vjust=1, angle=25))
p <- p +theme(axis.title.y = element_text(size=14))
p <- p +theme(axis.text.y = element_text(size=12))
p <- p +theme(legend.title = element_blank())
p <- p +theme(legend.text = element_text(size=12))
p <- p +theme(legend.position = c(0.15,0.8))
p <- p +scale_x_date(breaks="1 month", labels = date_format("%b '%y"), expand=c(0.025,0.025), limit=c(as.Date("2018-07-19"), as.Date("2019-04-07")))
p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=0, yend=1550), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=0, yend=1550), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-03-22"), xend=as.Date("2019-03-22"), y=0, yend=1550), size=0.25, linetype='dashed')
p <- p +annotate('text', x=as.Date("2018-10-09"), y=1550/2, hjust=0.5, vjust=0, label='Rollover', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-01-09"), y=1550/2, hjust=0.5, vjust=0, label='Revocation', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-03-20"), y=1550/2, hjust=0.5, vjust=0, label='Removal', angle=90, size=5)

plot_name <- paste(plot_path, '/', 'all_sentinel.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=6, dpi=300, units="cm")
