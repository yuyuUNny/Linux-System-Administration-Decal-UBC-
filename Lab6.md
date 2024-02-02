## Which networked services are already running?

There are multiple networked services running on your VM right now. To output the networked services running on the VM use `netstat` (install using apt).

- **Question 1a:** What command did you use to display the networked services?
`netstat -p `(I'm not very sure because I can't understand very well what is "networked services")

- **Question 1b:** Paste the output of the command.
Active Internet connections (w/o servers)
```
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 10.0.2.15:ssh           _gateway:64390          ESTABLISHED 1354/sshd: lucus [p
udp        0      0 ubuntu1:bootpc          _gateway:bootps         ESTABLISHED 757/NetworkManager
Active UNIX domain sockets (w/o servers)
Proto RefCnt Flags       Type       State         I-Node   PID/Program name     Path
unix  3      [ ]         STREAM     CONNECTED     30231    1457/dbus-daemon     /run/user/126/at-spi/bus
unix  3      [ ]         STREAM     CONNECTED     27268    1374/pipewire-pulse
...
```

- **Question 1c:** Choose one service from the output and describe what it does.
sshd: providing secure remote access to another system over a network.
NetworkManager: providing network configuration and management for Linux-based operating systems.

- **Question 2a:** What is the systemctl command to show whether bind9 is running or not?
`systemctl status bind9`

- **Question 2b:** Why does the dig command (dig ocf.berkeley.edu) work if @localhost is not present at the end (if bind9 is not started) but times out when @localhost is added?
Because with "@localhost" the `dig` send the request to the specified localhost DNS server (in this case bind9) but the bind9(Berkeley Internet Name Domain) has been closed so the command eventually times out. Without "@localhost" it will send the request to other DNS may have the response.

- **Question 2c:** What additional entries did you add to your DNS server config (the db.example.com file)?
```
;
; BIND data file example.com
;
$TTL    604800
@       IN      SOA     ns.example.com. root.example.com. (
                                1                     ; Serial
                                604800          ; Refresh
                                86400             ; Retry
                                2419200         ; Expire
                                604800 )        ; Negative Cache TTL
;
        IN      NS      ns.example.com.

ns  IN  A   127.0.0.1                ; IP for name server (random ip)
@   IN      A       1.2.3.4          ; A record for example.com (random ip)
test IN A 93.184.216.34
@ IN AAAA 2001:0db8:85a3:0000:0000:8a2e:0370:7334
@ IN MX 10 mail.example.com
; Add more records (Ex. CNAME, AAAA, MX, subdomains...)

```
";" means ignore by the DNS server this is for human to read
"@" means the main the domain "example.com"

- **Question 2d:** What commands did you use to make requests to the local DNS server for your additional entries?
`dig @localhost example.com AAAA`

- **Question 3a:** Do you notice any pattern when you refresh the page multiple times?
Hi, I am ID x

- **Question 3b:** What load balancing algorithm are you using?
roundrobin and leastconn

- **Question 3c:** What did you add to the haproxy config? (just copy and paste the lines you added to the bottom into here)
```
listen stats
  bind    0.0.0.0:7001
  mode    http
  stats   enable
  stats   hide-version
  stats   uri /stats

frontend my_frontend
bind 127.0.0.1:7000
default_backend my_backend

backend my_backend
balance leastconn
default-server check maxconn 5
server server0 127.0.0.1:8080
server server1 127.0.0.1:8081
server server2 127.0.0.1:8082
server server3 127.0.0.1:8083
server server4 127.0.0.1:8084
server server5 127.0.0.1:8085
```

- **Question 3d:** What do you notice has changed on the stats page after adding health checks? What color are each of the servers in the backend now?
before: ![[Screenshot 2024-02-02 at 11.13.12 pm.png]]
after:![[Screenshot 2024-02-02 at 11.13.52 pm.png]]

- **Question 3e:** What changes in the stats page when you crash a worker? What happened to the pattern from before?
![[Pasted image 20240202231705.png]]

- **Question 3f:** What HTTP status code (or error message) does HAProxy return if you crash all of the workers?
503 Service Unavailable
No server is available to handle this request. 