#!/usr/bin/env Rscript

require(readr)
require(ggplot2)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/data/root_canary/processed'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig'
plot_path = '../../../fig'

data_csv <- paste(data_path, '/', 'key_transition_large_providers.csv', sep='')
df <- read_csv(data_csv)
names(df) <- c('datetime','all','Google','Cloudflare','ISP')

p <- ggplot(df, aes(x=as.POSIXct(datetime, tz="UTC")))
p <- p +geom_segment(aes(x=as.POSIXct('2018-10-11 16:00:00', tz='UTC'), xend=as.POSIXct('2018-10-11 16:00:00', tz='UTC'), y=0, yend=1), size=0.75)
p <- p +geom_segment(aes(x=as.POSIXct('2018-10-13 16:00:00', tz='UTC'), xend=as.POSIXct('2018-10-13 16:00:00', tz='UTC'), y=0, yend=1), size=0.75, linetype = 'dashed')
p <- p +geom_step(aes(y=all/100.0, colour="All VPs"), size=0.5)
p <- p +geom_step(aes(y=Google/100.0, colour="Google"), size=0.5)
p <- p +geom_step(aes(y=Cloudflare/100.0, colour="Cloudflare"), size=0.5)
p <- p +geom_step(aes(y=ISP/100.0, colour="ISP"), size=0.5)
p <- p +ylab('% VPs with Key Cached')
p <- p +theme(axis.title.x = element_blank())
p <- p +theme(legend.title = element_blank())
p <- p +scale_x_datetime(date_breaks = "8 hour", date_labels = "%b %d-%H:%Mh", timezone = 'UTC', limits = c(as.POSIXct('2018-10-11 12:00:00', tz='UTC'), as.POSIXct('2018-10-14 18:00:00', tz='UTC')))
p <- p +theme(axis.text.x = element_text(angle=25, vjust=1.0, hjust=1.0))
p <- p +theme(legend.position = c(0.825, 0.5))
p <- p +geom_point(aes(x=as.POSIXct('2018-10-11 21:00:00', tz='UTC'), y=0.800), size=10, pch=1)
p <- p +annotate('text', x=as.POSIXct('2018-10-11 21:00:00', tz='UTC'), y=0.805, label='1', hjust=0.5, vjust=0.5, size=7)
p <- p +geom_point(aes(x=as.POSIXct('2018-10-12 04:00:00', tz='UTC'), y=0.50), size=10, pch=1)
p <- p +annotate('text', x=as.POSIXct('2018-10-12 04:00:00', tz='UTC'), y=0.505, label='2', hjust=0.5, vjust=0.5, size=7)
p <- p +geom_point(aes(x=as.POSIXct('2018-10-13 13:00:00', tz='UTC'), y=0.625), size=10, pch=1)
p <- p +annotate('text', x=as.POSIXct('2018-10-13 13:00:00', tz='UTC'), y=0.630, label='3', hjust=0.5, vjust=0.5, size=7)
p <- p +scale_y_continuous(labels = scales::percent)
p <- p +theme(axis.text.x = element_text(size=14))
p <- p +theme(axis.text.y = element_text(size=18))
p <- p +theme(axis.title.y = element_text(size=18))
p <- p +theme(legend.text = element_text(size=16))

p

plot_name <- paste(plot_path, '/', 'dnskey_providers.pdf', sep='')

ggsave(plot_name, p, device="pdf", width=16, height=10, dpi=300, units="cm")

