#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/data/addresses-per-day'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/addresses-per-day'
plot_path = '../../fig/addresses-per-day'

data_csv <- paste(data_path, '/', 'addr_per_day_merged.csv', sep='')
df <- read_csv(data_csv)

plot_rfc8145 <- function(df, v4_old, v4_new, v6_old, v6_new, ytop, ytitle) {
  p <- ggplot(df)
  p <- p +geom_line(aes(x=date, y=v4_old/(v4_old+v4_new), colour="IPv4"))
  p <- p +geom_line(aes(x=date, y=v6_old/(v6_old+v6_new), colour="IPv6"))
  p <- p +ylab(ytitle)
  p <- p +theme(axis.title.x = element_blank())
  p <- p +scale_x_date(breaks=c(as.Date('2018-02-01'), as.Date('2018-04-01'), as.Date('2018-06-01'), as.Date('2018-08-01'), as.Date('2018-10-01'), as.Date('2018-12-01')),labels = date_format("%b '%y"), limits = c(as.Date('2018-01-26'), as.Date('2018-12-12')))
  p <- p +theme(legend.title = element_blank())
  p <- p +theme(legend.position = c(0.9,0.5))
  
  # Annotate VPN releases
  vpn1 <- as.Date("2018-05-09")
  vpn2 <- as.Date("2018-07-09")
  vpn3 <- as.Date("2018-07-14")
  
  p <- p +geom_segment(aes(x=vpn1, xend=vpn1, y=0, yend=ytop), size=0.5, linetype='dotted')
  p <- p +annotate('text', x=vpn1+3, y=ytop-0.15, hjust=0.5, vjust=1, label='VPN release 1', angle=90, size=5)
  
  p <- p +geom_segment(aes(x=vpn2, xend=vpn2, y=0, yend=ytop), size=0.5, linetype='dotted')
  p <- p +annotate('text', x=vpn2-3, y=ytop-0.15, hjust=0.5, vjust=0, label='VPN release 2', angle=90, size=5)
  
  p <- p +geom_segment(aes(x=vpn3, xend=vpn3, y=0, yend=ytop), size=0.5, linetype='dotted')
  p <- p +annotate('text', x=vpn3+3, y=ytop-0.15, hjust=0.5, vjust=1, label='VPN release 3', angle=90, size=5)
  
  # Annotate rollover
  p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=0, yend=ytop), size=0.5, linetype='dashed')
  p <- p +annotate('text', x=as.Date("2018-10-14"), y=ytop/2, hjust=0.5, vjust=1, label='Actual rollover', angle=90, size=5)

  p <- p +theme(legend.text = element_text(size=12))
  p <- p +theme(axis.text.x = element_text(size=12))
  p <- p +theme(axis.text.y = element_text(size=12))
  p <- p +theme(axis.title.y = element_text(size=14))
  
  p
}

signal_plot <- plot_rfc8145(df, df$v4_old_count, df$v4_new_count, df$v6_old_count, df$v6_new_count, 0.5, 'Fraction of RFC 8145 signallers')
signal_new_plot <- plot_rfc8145(df, df$v4_old_firstseen, df$v4_new_firstseen, df$v6_old_firstseen, df$v6_new_firstseen, 0.725, 'Fraction of new RFC 8145 signallers')

plot_name <- paste(plot_path, '/', 'addrs-per-day.pdf', sep='')
ggsave(plot_name, signal_plot, device="pdf", width=16, height=8, dpi=300, units="cm")

plot_name <- paste(plot_path, '/', 'addrs-per-day-unique.pdf', sep='')
ggsave(plot_name, signal_new_plot, device="pdf", width=16, height=8, dpi=300, units="cm")
