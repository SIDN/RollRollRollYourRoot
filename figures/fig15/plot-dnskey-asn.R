#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(anchors)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/dnskey_asn_behavior_aj'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/verisign/dnskey_asn_behavior_aj'
plot_path = '.'

data_csv <- paste(data_path, '/', 'asn_behavior.csv', sep='')
df <- read_csv(data_csv)

df <- replace.value(df, 'Type', 'Post-Revocation and Pre-Removal', 'ASs-A')
df <- replace.value(df, 'Type', 'Post-Removal', 'ASs-B')
df <- replace.value(df, 'Type', 'Post-Roll / Pre-Revocation and Post-Removal', 'ASs-C')
df <- replace.value(df, 'Type', 'Post-Roll and Pre-Revocation', 'ASs-D')

p <- ggplot(df, aes(x=as.Date(Date),y=Queries,colour=Type))
p <- p +geom_line()
p <- p +ylab(bquote('Queries per day ('~log[10]~')'))
p <- p +theme(axis.title.x = element_blank())
p <- p +theme(legend.title = element_blank())
p <- p +theme(legend.text = element_text(size=12))
p <- p +theme(legend.position = c(0,1))
p <- p +theme(legend.justification = c(-0.15,1.08))
p <- p +theme(axis.text.x = element_text(size=12, hjust=0.575))
p <- p +theme(axis.text.y = element_text(size=12))
p <- p +theme(axis.title.y = element_text(size=14))
p <- p +scale_x_date(date_breaks="1 month", labels = date_format("%b '%y"), expand=c(0.025,0.025))
p <- p +scale_y_log10(breaks=c(10,100,1000,10000,100000,1000000), labels=c(expression(10^1), expression(10^2), expression(10^3), expression(10^4), expression(10^5), expression(10^6)))
p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=1, yend=10000000), size=0.25, linetype='dashed', colour="black")
p <- p +geom_segment(aes(x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=1, yend=10000000), size=0.25, linetype='dashed', colour="black")
p <- p +geom_segment(aes(x=as.Date("2019-03-22"), xend=as.Date("2019-03-22"), y=1, yend=10000000), size=0.25, linetype='dashed', colour="black")
p <- p +annotate('rect', xmin=as.Date("2018-08-01"), xmax=as.Date("2018-10-11"), ymin=1, ymax=10000000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2018-10-11"), xmax=as.Date("2019-01-11"), ymin=1, ymax=10000000, alpha=0.1)
p <- p +annotate('rect', xmin=as.Date("2019-01-11"), xmax=as.Date("2019-03-22"), ymin=1, ymax=10000000, alpha=0.2)
p <- p +annotate('rect', xmin=as.Date("2019-03-22"), xmax=as.Date("2019-04-01"), ymin=1, ymax=10000000, alpha=0.1)
p <- p +annotate('text', x=as.Date("2018-10-09"), y=3000, hjust=0.5, vjust=0, label='Rollover', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-01-09"), y=3000, hjust=0.5, vjust=0, label='Revocation', angle=90, size=5)
p <- p +annotate('text', x=as.Date("2019-03-20"), y=3000, hjust=0.5, vjust=0, label='Removal', angle=90, size=5)

plot_name <- paste(plot_path, '/', 'dnskey_asn_behaviors.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=6, dpi=300, units="cm")
