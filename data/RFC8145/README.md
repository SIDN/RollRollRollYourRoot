This directory contains raw, but anonymized, RFC 8145 data from root
name servers operated by Verisign.  There is one file per day, and each
file contains four fields:

1. Date as YYYY-MM-DD (UTC aligned)
2. Anonymized source IP address 
3. Key Tag list (decimal format, comma separated)
4. Count

Source IP address anonymization is consistent throughout all the data
files.

Count represents the number of times that a signal was recieved that
day from that source with the given key tags.
