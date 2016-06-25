`jonasjberg/dotfiles`
=====================

These are my personal configuration files. They probably won't be of much use
as-is but might provide some ideas for making your own. Free hosting is free.


**PLEASE NOTE:** Usage of these files are at your own peril!


If hypothetically, one were to forego this warning and decide to try these out,
something like the following command would probably work:


```bash
cd ~
git clone git@github.com:jonasjberg/dotfiles.git
cd dotfiles && chmod +x makesymlinks.sh && ./makesymlinks.sh
```


This will archive any existing configuration files to a timestamped
`tar.gz`-archive and create symlinks from the repo folder to ```$HOME```.  See
the `makesymlinks.sh` script for details.

