# Question 1: What is the name of a systemd service running on your system? What does it do? (If you’re not sure what it does, Google it!)
All the out put get from the `systemctl list-units --type=service` command can be an example. (I used to think only "systemd-xxx.service" can be)
A few examples that interest me: 
1) system-random-seed.service: a systemd service that plays a role in initializing the system's random number generator(by providing the kernel with a seed~~(although I'm not very sure what is "seed")~~). The out put is used for cryptographic purposes. (I think it might be like output private key for the information transfer？) 
3) systemctl status systemd-oomd.service: Out-of-Memory-Daemon, dealing with low memory condition.
4) systemd-fsck@dev-disk-by\x2duuid-4BEB\x2dB856.service: fsck is file system checking, and the characters after "@" is UUID(Universally Unique Identifier), "\x2d" is a hyphen("-"). The fsck process examines the integrity of the file system.(I think the use of UUID is to make sure the file system is the right one for the system even if the device names change(but why the device names change will make influence to the file system, but anyway))

#  Question 2:What is the difference between `systemctl reload yourservice` and `systemctl restart yourservice`?
I think "reload" just load the default setting file again, but "restart" close the whole service and then start load the service.
ChatGPT3.5: `reload` is generally less disruptive as it only applies configuration changes without restarting the service, while `restart` involves stopping and then starting the service, causing a brief interruption in service. Not all services support reloading, and in such cases, you may need to use `restart` to apply the changes.

#  Question 3: Upload a screenshot of your browser accessing the nginx webserver at http://[yourusername].decal.xcf.sh:420. Note: If you can’t access the IPv6 site use `curl localhost:420` on the VM and paste it’s contents (it should be a html page).
It looks like it's an internal web page, I can't complete this.T T

## What units needs to be started before a webserver starts? (Hint: you can get a list of special “target” units using `systemctl --type=target`.)
network.target
## What script should systemd run to start the webserver?
decal-labs/4/run
## Units run by root as default. Is that a safe practice for web servers?
Unsafe, because the root have too much privileges and that may make some bad action to the system. Also it can get some sensitive information.

# **Question 4:** What command did you run to crash the service?
Firstly I run "localhost:5000/crash"
![[Screenshot 2024-01-27 at 4.13.21 pm.png]]
Second I try use kill
![[Screenshot 2024-01-27 at 4.04.25 pm.png]]
(just in case I didn't learn what is json and cURL for now)

PS: At first, toy.service didn't work after following the previous steps. Use `journalctl -u toy.service` 
![[Screenshot 2024-01-27 at 3.54.48 pm.png]]
So double check the username and the path to the script and reload.

# Question 5: Upload your fully featured `toy.service` file to Gradescope.
![[Screenshot 2024-01-27 at 4.25.22 pm.png]]
