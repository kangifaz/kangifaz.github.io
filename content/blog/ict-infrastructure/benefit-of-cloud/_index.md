---
date: '2025-09-03T01:06:55+07:00'
draft: true
title: 'Benefit of Cloud'
---
hubahuba

```
root@Hydra:/home# df
Filesystem                       1K-blocks    Used Available Use% Mounted on
/dev/mapper/pve-vm--102--disk--0  10218772 8947904    730196  93% /
none                                   492       4       488   1% /dev
efivarfs                               192      38       150  20% /sys/firmware/efi/efivars
tmpfs                             20455780       0  20455780   0% /dev/shm
tmpfs                              8182312     112   8182200   1% /run
tmpfs                                 5120       0      5120   0% /run/lock
tmpfs                              4091156       4   4091152   1% /run/user/0
root@Hydra:/home# 
```

After
```
root@Hydra:~# df
Filesystem                       1K-blocks    Used Available Use% Mounted on
/dev/mapper/pve-vm--102--disk--0  17435452 8947948   7579832  55% /
none                                   492       4       488   1% /dev
efivarfs                               192      38       150  20% /sys/firmware/efi/efivars
tmpfs                             20455780       0  20455780   0% /dev/shm
tmpfs                              8182312     108   8182204   1% /run
tmpfs                                 5120       0      5120   0% /run/lock
tmpfs                              4091156       4   4091152   1% /run/user/0
root@Hydra:~# 

```

focus on 