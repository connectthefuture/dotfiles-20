ZSH
---

1. Download ZSH
    $ apt-get install zsh

2. Install oh-my-zsh
    $ export ZSH=/home/spock/dotfiles/oh-my-zsh
    $ wget --no-check-certificate http://install.ohmyz.sh -O - | sh

3. Set zsh to default shell
    $ chsh -s $(which zsh)

   Alternatively, do
    $ sudo update-alternatives --config x-terminal-emulator

4. Run makesymlinks.sh
    $ ~/dotfiles/makesymlinks.sh



VIM
---

1. Install Vim!

2. Setup Vundle
    $ git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim

3. Install Plugins
Launch vim and run 
    :PluginInstall
To install from command line
    vim +PluginInstall +qall

4. Install powerline fonts
    $ apt-get install fonts-powerline 

5. Create folders for temporary files
   .. With one fancy one-liner:
    $ mkdir ~/.vim/.{undo,backup,swp}

   .. or keep it simple(r):
    $ mkdir ~/.vim/.undo
    $ mkdir ~/.vim/.backup
    $ mkdir ~/.vim/.swp
