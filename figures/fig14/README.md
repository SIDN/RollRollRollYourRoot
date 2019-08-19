Per DNS query and root server the DNS response size binned, as reported in RSSAC data (https://github.com/rssac-caucus/rssac002-data).

DNSKEY responses fall into the 1232 and 1472 bytes bin.

./data contains one csv per participating root server with the following fields:

date				Date

udp_0_to_512		UDP DNS response between 0 and 512 bytes

udp_512_to_1232		UDP DNS response between 512 and 1232 bytes

udp_1232_to_1472	UDP DNS response between 1232 and 1472 bytes

udp_over_1472		UDP DNS response larger than 1472 bytes

tcp_0_to_512		TCP DNS response between 0 and 512 bytes

tcp_512_to_1232		TCP DNS response between 512 and 1232 bytes

tcp_1232_to_1472	TCP DNS response between 1232 and 1472 bytes

tcp_over_1472		TCP DNS response larger than 1472 bytes
