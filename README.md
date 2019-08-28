This is the Data Repository of the IMC 19 paper
# Roll, Roll, Roll your Root: A Comprehensive Analysis of the First Ever DNSSEC Root KSK Rollover

## Abstract

The DNS Security Extensions (DNSSEC) add authenticity and integrity to
_the_ naming system of the Internet. Resolvers that validate
information in the DNS need to know the cryptographic public key
used to sign the root zone of the DNS. Eight years after the introduction of this
key and one year after it was scheduled originally, this key was replaced by ICANN for
the first time in October 2018. ICANN considered this event, called a _rollover_, 
_''an overwhelming success''_ and during the rollover they detected
_''no significant outages''_.

In this paper, we independently follow the process of the rollover starting from the events
that lead to its postponement in 2017 until the removal of the old
key in 2019. We collected data from multiple vantage points in the DNS ecosystem
for the entire duration of the rollover process. Using this data, we study key
events of the rollover. These include telemetry signals that led to
the rollover being postponed, a near real-time view of the actual
rollover in resolvers and a significant increase in queries 
to the root of the DNS once the old key was revoked. Our analysis contributes
significantly to identifying the causes of challenges observed during the rollover.
We show that while from an end-user perspective, the roll indeed passed without
major problems, there are many opportunities for improvement and important lessons to be learned from events that 
occurred over the entire duration of the rollover. Based on these lessons, 
we propose improvements to the process for future rollovers.

## Content

This repository contains three directories:

### figures

This directory contains the data and code which is necessary to create the figures of the paper. The data is already preprocessed and stems from different sources.

### code 

This directory contains the full source code of the experiments carried out in Section 4.3.2 to identify a bug in a recursive resolver software. 

### data/RFC8145

This directory contains raw, but anonymized, RFC 8145 data from root
name servers operated by Verisign.
