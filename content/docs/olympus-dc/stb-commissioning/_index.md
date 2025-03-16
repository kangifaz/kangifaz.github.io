---
date: '2025-01-19T11:00:28+07:00'
draft: false
title: 'STB ZTE Commissioning'
---
## ARP Duplication Analysis due to Duplicate VM

My Armbian
```
    _             _    _              ___  ___ 
   /_\  _ _ _ __ | |__(_)__ _ _ _    / _ \/ __|
  / _ \| '_| '  \| '_ \ / _` | ' \  | (_) \__ \
 /_/ \_\_| |_|_|_|_.__/_\__,_|_||_|  \___/|___/
                                               
 v24.11.0 for Aml.S905x running Armbian Linux 5.15.169-ophub

 Packages:     Debian stable (bullseye)
 Updates:      Kernel upgrade enabled and 4 packages available for upgrade 
 IP addresses: (LAN) IPv4: XXX.XXX.XXX.XXX
 Performance:  

 Load:         2%               Up time:       4 days 9:14
 Memory usage: 9% of 1.76G  
 CPU temp:     50°C             Usage of /:    37% of 6.5G   
 RX today:     8 MiB     
```


### Symptoms
```

root: ping 100.0.0.221
PING 100.0.0.221 (100.0.0.221): 56 data bytes
92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 7d8d   0 0000  3f  01 353e 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 d648   0 0000  3f  01 dc82 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 b29b   0 0000  3f  01 0030 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 bb98   0 0000  3f  01 f732 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 6240   0 0000  3f  01 508b 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 e19e   0 0000  3f  01 d12c 100.0.0.1  100.0.0.221 

92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
Vr HL TOS  Len   ID Flg  off TTL Pro  cks      Src      Dst
 4  5  00 0054 d335   0 0000  3f  01 df95 100.0.0.1  100.0.0.221 

64 bytes from 100.0.0.221: icmp_seq=10 ttl=64 time=0.729 ms
64 bytes from 100.0.0.221: icmp_seq=11 ttl=64 time=0.912 ms
64 bytes from 100.0.0.221: icmp_seq=12 ttl=64 time=0.961 ms
64 bytes from 100.0.0.221: icmp_seq=13 ttl=64 time=1.045 ms
64 bytes from 100.0.0.221: icmp_seq=14 ttl=64 time=0.733 ms
64 bytes from 100.0.0.221: icmp_seq=15 ttl=64 time=0.992 ms
64 bytes from 100.0.0.221: icmp_seq=16 ttl=64 time=0.635 ms
64 bytes from 100.0.0.221: icmp_seq=17 ttl=64 time=0.950 ms
64 bytes from 100.0.0.221: icmp_seq=18 ttl=64 time=0.498 ms
64 bytes from 100.0.0.221: icmp_seq=19 ttl=64 time=0.538 ms
92 bytes from 100.0.0.223: Redirect Host(New addr: 100.0.0.221)
```

ARP Table

```
pool-100-0-0-221.bstnma.fios.verizon.net (100.0.0.221) at 00:15:18:01:81:31 on vtnet1
pool-100-0-0-222.bstnma.fios.verizon.net (100.0.0.222) at 00:15:18:01:81:31 on vtnet1
pool-100-0-0-223.bstnma.fios.verizon.net (100.0.0.223) at 00:15:18:01:81:31 on vtnet1
```

### Ask GPT
- Use of Virtual IP or Load Balancer
Virtual IP (VIP): If 100.0.0.221, 100.0.0.222, and 100.0.0.223 are Virtual IP addresses managed by devices such as a Load Balancer or High Availability Cluster, then using the same MAC address is expected. VIP allows multiple IP addresses to point to a single physical MAC address, enabling failover and load balancing.
Configuration Issues: If the VIP or load balancer is misconfigured, such as incorrect routing or ARP settings, it may cause packet delivery confusion, resulting in ICMP Redirect messages.

- Incorrect Routing Configuration
Conflicting Routing Tables: If there are conflicting or inconsistent routes on the switch or router connecting your server, the device may send redirect messages to attempt to reroute traffic more efficiently.
Default Gateway: Ensure that the default gateway on your Armbian server is configured correctly. Incorrect default gateway configurations can lead to other network devices sending ICMP Redirect messages.

- Network Loop
Physical or Logical Loop: The presence of a loop in the network, either physical (e.g., redundant cable connections without proper configuration) or logical (e.g., routing that creates a loop), can cause packets to circulate endlessly. Network devices may send ICMP Redirect messages in an attempt to resolve the loop.
Spanning Tree Protocol (STP): If the switch you are using supports STP, ensure that it is enabled and correctly configured to prevent network loops.

- IP Conflict
Duplicate IP Addresses: If another device on the network is accidentally using IP addresses 100.0.0.221, 100.0.0.222, or 100.0.0.223, it can cause conflicts, leading to ICMP Redirect messages.

- ARP Cache Issues
Inconsistent ARP Cache: Although no duplication was observed in the ARP output you provided, issues such as inconsistent or stale entries in the ARP cache could still cause devices to send redirect messages.

These potential causes should be investigated to identify and resolve the source of the ICMP Redirect messages in your network.

### Solution
Set mac address temp

```
sudo ip link set dev eth0 address AA:BB:CC:DD:EE:FF
```

### Make it Permanent

run command
```
nmcli connection show
```

sample
```
atomos-02:~:# nmcli connection show

NAME                UUID                                  TYPE      DEVICE 
Wired connection 1  1eb2e9d9-b6da-39ce-96cc-9a197a8854c3  ethernet  eth0   
atomos-02:~:# 
```

result is `Wired connection 1`, then run command

edit the file
```
atomos-02:~:# nano "/etc/NetworkManager/system-connections/Wired connection 1.nmconnection"
```

and the content is

```
...
[ethernet]
mac-address-blacklist=
cloned-mac-address=AA:BB:CC:DD:EE:FF # <- edit here
[ipv4]
address1=XXX.XXX.XXX.XXX/YY,XXX.XXX.XXX.XXX # IP Address, Gatway IP
dns=XXX.XXX.XXX.XXX; # IP Address of DNS Server
dns-search=
method=manual

...

```
Restart Service
```
sudo systemctl restart NetworkManager
```

### Verification
run command 
```
ifconfig ethX
ip link show ethX 
```

Ensure after reboot still on same mac address
reboot
```
sudo reboot
```
```
ifconfig ethX
ip link show ethX 
```