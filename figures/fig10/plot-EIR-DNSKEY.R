#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/eir'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/eir'
plot_path = '.'

data_csv <- paste(data_path, '/', 'eir_ranges_dnskey_aj_daily.csv', sep='')
df <- read_csv(data_csv)

p <- ggplot(df, aes(x=as.Date(Date)))
p <- p +geom_line(aes(y=Queries, colour="Queries per day"))
#p <- p +ylab('DNSKEY queries per day')
p <- p +ylab('Queries per day')
p <- p +theme(axis.title.y = element_text(size=14))
p <- p +theme(axis.text.y = element_text(size=12))
p <- p +theme(axis.title.x = element_blank())
p <- p +theme(axis.text.x = element_text(size=12, hjust=1, vjust=1, angle=25))
p <- p +theme(legend.position = "none")
p <- p +scale_x_date(breaks="1 month", labels = date_format("%b '%y"), expand=c(0.025,0.025))
p <- p +scale_y_continuous()
p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=0, yend=120000), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=0, yend=120000), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-03-22"), xend=as.Date("2019-03-22"), y=0, yend=120000), size=0.25, linetype='dashed')
p <- p +annotate('rect', xmin=as.Date("2018-08-01"), xmax=as.Date("2018-10-11"), ymin=0, ymax=120000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2018-10-11"), xmax=as.Date("2019-01-11"), ymin=0, ymax=120000, alpha=0.1)
p <- p +annotate('rect', xmin=as.Date("2019-01-11"), xmax=as.Date("2019-03-22"), ymin=0, ymax=120000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2019-03-22"), xmax=as.Date("2019-04-01"), ymin=0, ymax=120000, alpha=0.1)
p <- p +annotate('text', x=as.Date("2018-10-09"), y=60000, hjust=0.5, vjust=0, label='Rollover', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-01-09"), y=60000, hjust=0.5, vjust=0, label='Revocation', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-03-20"), y=60000, hjust=0.5, vjust=0, label='Removal', angle=90, size=5)

plot_name <- paste(plot_path, '/', 'eir_dnskey_aj.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=6, dpi=300, units="cm")
