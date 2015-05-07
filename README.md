jonasjberg/dotfiles
===================

Configuration files for common *nix (Linux) utilities; Bash, VIM, Zsh, Thunar,
etc..


introduction
------------
These are my personal configuration files.  I keep them here to make installing
to different machines easier.  Version controlling configuration files is the
way to go, changes are easy to keep track of and document and restoring to any
previous state or combination of states is easy. Not to mention recovering from
fatal edits ..

I would recommend you write your own, don't just use someone elses as is, even
if a setup would be written solely for the purpose of full portability, it
probably won't work out, and won't be much fun.


installing
----------
**PLEASE NOTE that any and all usage of these files are at your own peril.**

If hypothetically, one were to forego any and all warnings and decide to
install, something like the following would probably work:


```bash
cd ~
git clone git@github.com:jonasjberg/dotfiles.git
chmod +x makesymlinks.sh && ./makesymlinks.sh
```


This will archive any existing configuration files to a timestamped
.tar.gz-file, and symlink from the repo folder to ```$HOME```.
