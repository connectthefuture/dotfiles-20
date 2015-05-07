HOW-TO
======

Condensed install instructions for setting up a new enviroment.
This assumes Ubuntu repositories or equivalent. Apt can be whatever package
manager. Also, PLEASE NOTE that any usage is at your peril. Also kittens.

--------------------------------------------------------------------------------


ZSH
---

1. Download ZSH

$ apt-get install zsh

2. Install oh-my-zsh. Assumes you really trust their code ..

    export ZSH=/home/spock/dotfiles/oh-my-zsh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh

3. Set zsh to default shell:

    chsh -s $(which zsh)

   Alternatively, do:

    sudo update-alternatives --config x-terminal-emulator

4. Run makesymlinks.sh:

    ~/dotfiles/makesymlinks.sh


VIM
---

1. Install Vim using your preferred method, maybe like so:

    apt-get install vim vim-youcompleteme

2. Setup Vundle:

    git clone https://github.com/gmarik/Vundle.vim.git \
                ~/dotfiles/vim/bundle/Vundle.vim

3. Install Plugins. First launch Vim, then run:

    :PluginInstall

Alternatively, to install from the command line:

    vim +PluginInstall +qall

4. Install powerline fonts.

    apt-get install fonts-powerline 

5. Create folders for temporary files
   .. With one fancy one-liner:

    mkdir ~/.vim/.{undo,backup,swp}

   .. or keep it simple(r):

    mkdir ~/.vim/.undo
    mkdir ~/.vim/.backup
    mkdir ~/.vim/.swp
