### Encryption and Decryption

1. Decrypt `file1.txt.gpg` with the password `ocfdecal` (_for real-life purposes, never store passwords in plaintext_). What are the decrypted contents of `file1.txt.gpg`?
   Answer: Quack
   `echo "ocfdecal" | gpg --batch --passphrase-fd 0 --decrypt file1.txt.gpg`
   `gpg --batch --passphrase ocfdecal --decrypt file1.txt.gpg
   --batch: Use batch mode. Never ask, do not allow interactive commands.
   --passphrase-fd n : Read the passphrase from file descriptor _n_. If you use 0 for _n_, the passphrase will be read from stdin. This can only be used if only one passphrase is supplied. Don't use this option if you can avoid it.
   <br>
2. What command allows you to import a key?
   `--import [_files_], --fast-import [_files_]`: Import/merge keys. This adds the given keys to the keyring. The fast version does not build the trustdb; this can be done at any time with the command --update-trustdb
   <br>
3. What command allows you to export a key to a file? (Add the `--armor` flag to ASCII-encode the key so it can be sent easily in text form)
  ` --export [_names_]`: Either export all keys from all keyrings (default keyrings and those registered via option --keyring), or if at least one name is given, those of the given name. The new keyring is written to stdout or to the file given with option "output". Use together with --armor to mail those keys.
  <br>
4. What command allows you to see all of the keys on your keyring?
   `--list-keys [_names_], --list-public-keys [_names_]`: List all keys from the public keyrings, or just the ones given on the command line.
   `--list-secret-keys [_names_]`: List all keys from the secret keyrings, or just the ones given on the command line.
   <br>
6. Use the private key `lab7privkey` to decrypt the file `file2.txt.gpg` (_for real-life purposes, it is necessary to keep private keys secret_). What are the decrypted contents of `b8/file2.txt.gpg`?
   ```
   $ gpg --import "lab7privkey"
   gpg: key 82DDDAA6869E6CEC: public key "lab7privkey" imported
   gpg: key 82DDDAA6869E6CEC: secret key imported
   gpg: Total number processed: 1
   gpg:               imported: 1
   gpg:       secret keys read: 1
   gpg:   secret keys imported: 1 
   $ gpg --decrypt file2.txt.gpg
   gpg: Note: secret key 83ADADD521C1D38D expired at Tue 31 Oct 2023 07:00:00 PM UTC
   gpg: encrypted with 2048-bit RSA key, ID 83ADADD521C1D38D, created 2018-10-31
        "lab7privkey"
   Woof
   ```
    (But "lab7privkey" is a private key I don't know why it contained as a public key)
    And the decrypted contents of b8/file2.txt: Woof
<br>
### Hashing (Checksums)

1. What is the MD5 hash of `file3.txt`?
   ```
   $ md5sum file3.txt
   ddbefc9c1d8a8d9195a420a7181352e9  file3.txt
   ```
2. What is the SHA1 hash of the MD5 hash of `file3.txt`? In other words, what is `SHA1(MD5(file3.txt))`?
   ```
   $ echo "ddbefc9c1d8a8d9195a420a7181352e9" | sha1sum
   15c3d7fa41fcc2ed98c2fda065e3248047a048f4  -
   ```
   - Incorrect command: `md5sum file3.txt > a.txt | sha1sum` (can't use "|" after ">")
   - correct command but incorrect output: `md5sum file3.txt | sha1sum` (It output the SHA1 hash of the MD5 hash of file3.txt + file3.txt)   
   <br>
### [](https://decal.ocf.berkeley.edu/archives/2023-fall/labs/7/#file-security-1)File Security

Run `sudo setup.sh` before beginning this section.

1. `file4.txt`: What are the permissions of this file? Explain what they allow and disallow.
   `-rw-r--r-- 1 nobody lucus   15 Feb  3 07:04 file4.txt`
   `-`: this is a file
   `rw-`: readable and writable for "nobody"
   `r--r--`: read only for group and other
   `1`: indicates the number of hard links to the file
   `nobody`: user owner of the file
   `lucus`: group owner of the file
   `15`: file size in bytes
   `Feb 3 07:04`: last modification timestamp of the file
   <br>
2. `file5`: Make this file executable and execute it. What is its printout?
   ```
   $ chmod +x file5
   $ ./file5
   -bash: ./file5: cannot execute binary file: Exec format error
   $ file file5
   file5: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically      linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32,           BuildID[sha1]=fba4dfb4c3e61e810339d350b131607d5c76d3a1, not stripped
   $ uname -m
   aarch64
   ```
    Unfortunately:(
    <br>
3. `file6.txt`: Change this file to be under your ownership. What command did you use?
   `$ sudo chown lucus:lucus file6.txt`
   <br>
4. `file7.txt`: Make this file readable only to you. What command did you use?
   `$ sudo chown lucus:lucus file7.txt`
   <br>
5. `file8.txt`: Change this file’s permissions such that only root should be able to read this file and no one should be able to edit it. What command did you use?
   `sudo chown root:root file8.txt`
   `sudo chmod 511 file8.txt`(r:4;w:2;x:1)
   `-r-x--x--x 1 root   root    20 Feb  3 07:25 file8.txt`
   <br>
6. `file9.txt`: Choose any method to make this file readable to you and unreadable to the previous owner. What command did you use?
```
$ sudo groupadd developers
$ sudo usermod -aG developers lucus
$ sudo chown lucus:developers file9.txt
$ chmod o-r file9.txt
$ ls -l
...
-rwxrwx-wx 1 lucus  developers   19 Feb  3 07:25 file9.txt
```
There will make the file readable to other users while ensuring the previous owner has no access. (add other users except the previous user into the specific group)