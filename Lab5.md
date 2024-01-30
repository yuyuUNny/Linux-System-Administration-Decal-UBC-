## Short Answer Questions

### Does HTTP use TCP or UDP and why? How about Discord and Skype, why?
Http use TCP, because the page need reliable information transportation to establish and cannot accept the lost of any package. And for Discord and Skype the real-time connection are more important, even if some package lost people can understand the information from the context, so UDP are better choice.
### Who manufactured the NIC with mac address 52:54:00:d7:ce:cc?
As google this must be a virtual mechine, maybe QEMU, but ChatGPT just say it is from VMware.
### How many distinct hosts can 127.0.0.0/8 contain?
32-8=24bit
2^24-2=16777216-2=16777214(reserve 127.0.0.0 and 127.255.255.255)
### What are three types of records you can get when you perform a DNS lookup of google.com using the dig command?
(Can't understand, using `dig www.google.com` only get Address: 142.250.194.142
### Is the result of running ping enough to determine whether or not you can reach a server? Why or why not?
No, because the service may reject a ping request but can be accessed normally or the ping can be reachable but other service can't be use.

## Programming Exercise
1. is_on.sh
```
#!/bin/bash

HOST=$1

ping -c1 $HOST > $HOST.txt 2>&1

if [[ $(grep -o '[0-1] received' $HOST.txt) == "1 received" ]]; then
        echo "OK"
else
        echo "Host is not reachable"
fi

rm -rf $HOST.txt
```

2. (Can't understand why these step which looks massive)
   - To find the MAC address of network interface eth0:
   `ip link show eth0`
   - use `head` and `tail` command and pipes to tailor `ip`’s output to one line:
   `echo $(ip link show docker0 | head -n 1)$(ip link show docker0 | tail -n 1)`
  -  Use `cut` command ([Examples](https://www.geeksforgeeks.org/cut-command-linux-examples/)) to get the MAC address:(use `echo "string" | wc -c` to counts the number of byte of the string)
   `cut -c 118-135`
   