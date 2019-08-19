#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/dnskey_aj'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/dnskey_aj'
plot_path = '.'

data_csv <- paste(data_path, '/', 'daily_aj_dnskey_counts.csv', sep='')
df <- read_csv(data_csv)

p <- ggplot(df, aes(x=as.Date(Date)))
p <- p +geom_line(aes(y=Queries, colour="Queries per day"))
#p <- p +ylab('DNSKEY queries per day')
p <- p +ylab('Queries per day')
p <- p +theme(axis.title.y = element_text(size=14))
p <- p +theme(axis.text.y = element_text(size=12))
p <- p +theme(axis.title.x = element_blank())
p <- p +theme(axis.text.x = element_text(angle=25, hjust=1.0, vjust=1.0, size=12))
p <- p +theme(legend.position = "none")
p <- p +scale_x_date(breaks="1 month", labels = date_format("%b '%y"), expand=c(0.025,0.025))
p <- p +scale_y_continuous(label = unit_format(unit = "M", scale = 1e-6))
p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=0, yend=1200000000), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=0, yend=1200000000), size=0.25, linetype='dashed')
p <- p +geom_segment(aes(x=as.Date("2019-03-22"), xend=as.Date("2019-03-22"), y=0, yend=1200000000), size=0.25, linetype='dashed')
p <- p +annotate('rect', xmin=as.Date("2018-08-01"), xmax=as.Date("2018-10-11"), ymin=0, ymax=1200000000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2018-10-11"), xmax=as.Date("2019-01-11"), ymin=0, ymax=1200000000, alpha=0.1)
p <- p +annotate('rect', xmin=as.Date("2019-01-11"), xmax=as.Date("2019-03-22"), ymin=0, ymax=1200000000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2019-03-22"), xmax=as.Date("2019-04-01"), ymin=0, ymax=1200000000, alpha=0.1)
p <- p +annotate('text', x=as.Date("2018-10-09"), y=600000000, hjust=0.5, vjust=0, label='Rollover', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-01-09"), y=600000000, hjust=0.5, vjust=0, label='Revocation', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-03-20"), y=600000000, hjust=0.5, vjust=0, label='Removal', angle=90, size=5)
p <- p +geom_point(aes(x=as.Date('2018-10-18'), y=175000000), size=6, pch=1)
p <- p +annotate('text', x=as.Date('2018-10-18'), y=175000000, label='1', hjust=0.5, vjust=0.5)
p <- p +geom_point(aes(x=as.Date('2019-01-18'), y=175000000), size=6, pch=1)
p <- p +annotate('text', x=as.Date('2019-01-18'), y=175000000, label='2', hjust=0.5, vjust=0.5)
p <- p +geom_point(aes(x=as.Date('2019-03-16'), y=1050000000), size=6, pch=1)
p <- p +annotate('text', x=as.Date('2019-03-16'), y=1050000000, label='3', hjust=0.5, vjust=0.5)
p <- p +geom_point(aes(x=as.Date('2019-03-29'), y=175000000), size=6, pch=1)
p <- p +annotate('text', x=as.Date('2019-03-29'), y=175000000, label='4', hjust=0.5, vjust=0.5)
p

plot_name <- paste(plot_path, '/', 'all_R.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=32, height=6, dpi=300, units="cm")

plot_name <- paste(plot_path, '/', 'all_R_singlecol.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=6, dpi=300, units="cm")
