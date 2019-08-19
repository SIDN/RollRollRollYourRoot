#!/usr/bin/env Rscript

require(readr)
require(ggplot2)
require(scales)
require(tidyr)
require(ggpubr)

#data_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/dnsthought'
data_path = '.'
#plot_path = '/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/fig/dnsthought'
plot_path = '.'

plot_topasns_sentinel <- function(df,ksk_label,drop_x_labels = FALSE) {
  molten_ta <- gather(df, ASN, value, AS7922, AS2119, AS8767, AS37100, AS15169, AS16276, AS13335, AS6830)
  
  ytop <- 550
  
  p <- ggplot(molten_ta, aes(x=as.Date(date)))
  p <- p + geom_area(aes(y=value,fill=ASN))
  p <- p +theme(axis.title.x = element_blank())
  p <- p +theme(axis.title.y = element_blank())
  p <- p +theme(legend.title = element_blank())
  p <- p +theme(legend.text = element_text(size=12))
  p <- p +scale_x_date(breaks="1 month", labels = date_format("%b '%y"), expand=c(0.025,0.025), limit=c(as.Date("2018-07-19"), as.Date("2019-04-07")))
  p <- p +theme(axis.text.x = element_text(angle=25, vjust=1.0, hjust=1.0, size=12))
  p <- p +theme(axis.text.y = element_text(size=12))
  if (drop_x_labels == TRUE) {
    p <- p +theme(axis.ticks.x = element_blank())
    p <- p +theme(axis.text.x = element_blank())
  }
  p <- p +geom_segment(aes(x=as.Date("2018-10-11"), xend=as.Date("2018-10-11"), y=0, yend=ytop), size=0.25, linetype='dashed')
  p <- p +geom_segment(aes(x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=0, yend=ytop), size=0.25, linetype='dashed')
  p <- p +geom_segment(aes(x=as.Date("2019-03-22"), xend=as.Date("2019-03-22"), y=0, yend=ytop), size=0.25, linetype='dashed')
  p <- p +annotate('text', x=as.Date("2018-10-09"), y=ytop/2, hjust=0.5, vjust=0, label='Rollover', angle=90, size=5)
  p <- p +annotate('text', x=as.Date("2019-01-09"), y=ytop/2, hjust=0.5, vjust=0, label='Revocation', angle=90, size=5)
  p <- p +annotate('text', x=as.Date("2019-03-20"), y=ytop/2, hjust=0.5, vjust=0, label='Removal', angle=90, size=5)
  #p <- p +geom_label(x=as.Date("2018-07-15"), y=500, label=ksk_label, hjust=0, vjust=0.5, size=6)
  p <- p +annotate('text', x=as.Date("2018-07-19"), y=500, label=ksk_label, hjust=0, vjust=0.5, size=5)
  p
}

ta_19036_csv <- paste(data_path, '/', 'dnsthought_sentinel_topasns_ta_19036.csv', sep='')
df_19036 <- read_csv(ta_19036_csv)

ta_20326_csv <- paste(data_path, '/', 'dnsthought_sentinel_topasns_ta_20326.csv', sep='')
df_20326 <- read_csv(ta_20326_csv)

plot_19036 <- plot_topasns_sentinel(df_19036, 'KSK-2010', TRUE)

plot_20326 <- plot_topasns_sentinel(df_20326, 'KSK-2017')

p <- ggarrange(plot_19036, plot_20326, ncol=1, nrow=2, common.legend = TRUE, legend="right", heights=c(0.44,0.56))
p <- annotate_figure(p, left = text_grob("Number of resolvers", rot = 90, size = 14))

plot_name <- paste(plot_path, '/', 'sentinel_topasns.pdf', sep='')
ggsave(plot_name, p, device="pdf", width=16, height=8, dpi=300, units="cm")
