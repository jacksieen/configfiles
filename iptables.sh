#!/bin/bash

IPT=/sbin/iptables

$IPT -N ETH0_TCP
$IPT -N ETH0_UDP
$IPT -A OUTPUT -j ACCEPT

$IPT -F INPUT
$IPT -A INPUT -i enp2s0 -p tcp -j ETH0_TCP
$IPT -A INPUT -i enp2s0 -p udp -j ETH0_UDP

#for tcp 
$IPT -F ETH0_TCP
$IPT -A ETH0_TCP -p tcp --dport 8392 -j ACCEPT  #port for sshd
$IPT -A ETH0_TCP -p tcp --dport 10040 -j ACCEPT #port for webmin
$IPT -A ETH0_TCP -p tcp --dport 80 -j ACCEPT    #port for webserver
$IPT -A ETH0_TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A ETH0_TCP -m state --state NEW -j DROP


#for udp
$IPT -F ETH0_UDP
$IPT -A ETH0_UDP -p udp --dport 514 -j ACCEPT    #port for syslog-ng
$IPT -A ETH0_TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A ETH0_TCP -m state --state NEW -j DROP

