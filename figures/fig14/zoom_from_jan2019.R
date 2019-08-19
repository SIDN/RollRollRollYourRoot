#!/usr/bin/env Rscript

require(ggplot2)
require(readr)
require(stats)
require(scales)

#data_path <- "/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/uncooked/rssac_respsize_dist/data"
#plots_path <- "/Users/rijswijk/Documents/UTwente/Papers/2019/root-ksk-roll/uncooked/rssac_respsize_dist/plots"
data_path <- "./data"
plots_path <- "./plots"

load_root_data <- function(root_letter) {
  rl_path <- paste(data_path, "/", root_letter, "-root-traffic-sizes.csv", sep="")
  rl_df <- read.csv(rl_path)
  rl_df
}

load_dnskey_data <- function(root_letter) {
  rl_path <- paste(data_path, "/", root_letter, "-dnskey-pct.csv", sep="")
  rl_df <- read.csv(rl_path)
  rl_df
}

get_root_geom_line <- function(dfitem, series_label) {
  geom_line(aes(y=dfitem/max(dfitem), colour=series_label))
}

# udp_0_to_512,udp_512_to_1232,udp_1232_to_1472,udp_over_1472,tcp_0_to_512,tcp_512_to_1232,tcp_1232_to_1472,tcp_over_1472
get_pct_root_geom_line <- function(df, series_label) { 
  geom_path(aes(y=(df$tcp_1232_to_1472+df$udp_1232_to_1472)/(df$udp_0_to_512+df$udp_512_to_1232+df$udp_1232_to_1472+df$udp_over_1472+df$tcp_0_to_512+df$tcp_512_to_1232+df$tcp_1232_to_1472+df$tcp_over_1472), colour=series_label), size=0.25)
}

get_dnskey_geom_line <- function(df, series_label) {
  geom_path(data=df, aes(x=as.Date(date), y=(percent_dnskey_queries/100.0), colour=series_label), linetype='dashed', size=0.75)
}

shade_weekends <- function(q, ymax) {
  q <- q +annotate('rect', xmin=as.Date("2018-12-22"), xmax=as.Date("2018-12-24"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2018-12-29"), xmax=as.Date("2018-12-31"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-01-05"), xmax=as.Date("2019-01-07"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-01-12"), xmax=as.Date("2019-01-14"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-01-19"), xmax=as.Date("2019-01-21"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-01-26"), xmax=as.Date("2019-01-28"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-02-02"), xmax=as.Date("2019-02-04"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-02-09"), xmax=as.Date("2019-02-11"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-02-16"), xmax=as.Date("2019-02-18"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-02-23"), xmax=as.Date("2019-02-25"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-03-02"), xmax=as.Date("2019-03-04"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-03-09"), xmax=as.Date("2019-03-11"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-03-16"), xmax=as.Date("2019-03-18"), ymin=0.0, ymax=ymax, alpha=0.2)
  q <- q +annotate('rect', xmin=as.Date("2019-03-23"), xmax=as.Date("2019-03-25"), ymin=0.0, ymax=ymax, alpha=0.2)
  q
}

load_plot_and_save <- function() {
  df_a <- load_root_data('a')
  df_a_actual <- load_dnskey_data('a')
  df_b <- load_root_data('b')
  df_c <- load_root_data('c')
  df_d <- load_root_data('d')
  df_e <- load_root_data('e')
  df_f <- load_root_data('f')
  df_h <- load_root_data('h')
  df_i <- load_root_data('i')
  df_j <- load_root_data('j')
  df_j_actual <- load_dnskey_data('j')
  df_k <- load_root_data('k')
  df_l <- load_root_data('l')
  df_m <- load_root_data('m')
  
  q <- ggplot(df_a, aes(x=as.Date(date)))
  q <- q +get_pct_root_geom_line(df_a, 'A')
  q <- q +get_dnskey_geom_line(df_a_actual, "A*")
  q <- q +get_pct_root_geom_line(df_b, 'B')
  q <- q +get_pct_root_geom_line(df_c, 'C')
  q <- q +get_pct_root_geom_line(df_d, 'D')
  q <- q +get_pct_root_geom_line(df_e, 'E')
  q <- q +get_pct_root_geom_line(df_f, 'F')
  q <- q +get_pct_root_geom_line(df_h, 'H')
  q <- q +get_pct_root_geom_line(df_i, 'I')
  q <- q +get_pct_root_geom_line(df_j, 'J')
  q <- q +get_dnskey_geom_line(df_j_actual, "J*")
  q <- q +get_pct_root_geom_line(df_k, 'K')
  q <- q +get_pct_root_geom_line(df_l, 'L')
  q <- q +get_pct_root_geom_line(df_m, 'M')
  q <- q +ylab('Fraction of traffic')
  q <- q +labs(colour="Root")
  q <- q +guides(colour=guide_legend(ncol=1, byrow=TRUE, keywidth=0.5, keyheight = 0.415, default.unit = 'cm'))
  q <- q +theme(legend.title = element_blank())
  q <- q +theme(legend.text = element_text(size=12))
  q <- q +theme(legend.box.margin=margin(-10,-10,-20,-10))
  q <- q +theme(axis.text.x = element_text(size=12))
  q <- q +theme(axis.text.y = element_text(size=12))
  q <- q +theme(axis.title.y = element_text(size=14))
  q <- q +theme(axis.title.x = element_blank())
  q <- q +annotate('rect', xmin=as.Date("2018-12-21"), xmax=as.Date("2019-01-11"), ymin=0, ymax=0.10, alpha=0.2)
  q <- q +annotate('text', x=as.Date("2019-01-01"), y=0.085, label="ZSK\nrollover", lineheight=0.8, size=4.5)
  q <- q +annotate('rect', xmin=as.Date("2019-01-11"), xmax=as.Date("2019-02-10"), ymin=0, ymax=0.10, alpha=0.1, fill="blue")
  q <- q +annotate('text', x=as.Date("2019-01-26"), y=0.085, label="RFC 5011\nhold-down\nfor revocation", lineheight=0.8, size=4.5)
  q <- q +annotate('segment', x=as.Date("2019-01-11"), xend=as.Date("2019-01-11"), y=0.0, yend=0.10)
  q <- q +geom_segment(aes(x=as.Date("2019-01-20"), xend=as.Date("2019-01-12"), y=0.055, yend=0.055), size=0.25, arrow=arrow(length = unit(0.25,"cm")))
  q <- q +annotate('text', x=as.Date("2019-01-21"), y=0.055, label="KSK-2010\nrevoked", hjust=0, vjust=0.5, lineheight=0.8, size=4.5)
  q <- q +ylim(c(0.0,0.10))
  q <- q +scale_x_date(breaks=c(as.Date('2019-01-01'), as.Date('2019-02-01'), as.Date('2019-03-01')),labels = date_format("%b '%y"), limits = c(as.Date('2018-12-21'), as.Date('2019-03-20')))
  # Uncomment line below to shade weekends
  #q <- shade_weekends(q, 0.1)
  
  ggsave(paste(plots_path, "/", "zoom_from_jan2019.pdf", sep=""), q, device="pdf", width=16, height=6, dpi=300, units="cm")
}

load_plot_and_save()
