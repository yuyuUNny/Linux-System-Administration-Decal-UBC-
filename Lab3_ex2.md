# Compiling and packaging

## Will we still be able to run "hellopenguin" from any directory if we packaged it into "/usr/share" instead of "/usr/bin"?
No, I try to rename the "bin" to "share" and create the package again and when I try to use "hellopenguin" there is `bash: cd: ex1: No such file or directory` . To solve this I use `export PATH=$PATH:/usr/share` and it work.

PS:https://fpm.readthedocs.io/en/v1.15.1/packages/dir.html?highlight=prefix#arguments-when-used-as-input-type 
I try to use `fpm -s dir -t deb -n hellopenguin -v 1.0~ocf1 -C packpenguin --prefix /usr/share` but it didn't work I don't know why:(


## What is your rationale for the previous answer?
I'm not very sure, but I think "/usr/bin" is generally used for PATH sothat the "fpm" tool make it a "FPM tool defaults to using /usr/bin when creating a package and adds /usr/bin to the PATH during installation.

# Debugging

## What package was missing after trying to install ocfspy?
The complied file of ocfdocs.c and the folder structure of where the executable shall reside in.

## What is the password that ocfspy outputs after fixing the dependency problem?
Passwork is Cyclone