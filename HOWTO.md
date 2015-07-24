HOW-TO
======

Condensed install instructions for setting up a new enviroment.
This assumes Ubuntu repositories or equivalent. Apt can be whatever package
manager. Also, PLEASE NOTE that any usage is at your peril. Also kittens.

--------------------------------------------------------------------------------


ZSH
---

1. Download ZSH

    ```bash
    apt-get install zsh
    ```
    
2. Install oh-my-zsh. Assumes you really trust their code ..

    ```bash
    export ZSH=/home/spock/dotfiles/oh-my-zsh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh
    ```

3. Set zsh to default shell:

    ```bash
    chsh -s $(which zsh)
    ```

   Alternatively, do:

    ```bash
    sudo update-alternatives --config x-terminal-emulator
    ```


VIM
---

1. Install Vim using your preferred method, maybe like so:

    ```bash
    apt-get install vim vim-youcompleteme
    ```

2. Setup Vundle:

    ```bash
    git clone https://github.com/gmarik/Vundle.vim.git \
              ~/dotfiles/vim/bundle/Vundle.vim
    ```

3. Install Plugins. First launch Vim, then run:

    ```bash
    :PluginInstall
    ```

   Alternatively, to install from the command line:

    ```bash
    vim +PluginInstall +qall
    ```

4. Install powerline fonts.

    ```bash
    apt-get install fonts-powerline 
    ```

5. Create folders for temporary files
   .. With one fancy one-liner:

    ```bash
    mkdir ~/.vim/.{undo,backup,swp}
    ```

   .. or keep it simple(r):

    ```bash
    mkdir ~/.vim/.undo
    mkdir ~/.vim/.backup
    mkdir ~/.vim/.swp
    ```

6. Install 'Youcompleteme' from Ubuntu repositories using 'vim-addon-manager'.
   Seems to be an overall easier solution than getting them through Vundle.
   The 'YouCompleteMe' install in particular is somewhat involved and I'd
   rather not go through the compilation process if at all possible..

    ```bash
    apt-get install vim-youcompleteme
    vam install youcompleteme 
    ```

7. While we're at it, go ahead and install more plugins from the Ubuntu
   repositories. I'm thinking it's best to keep to just the one source for
   vim addons. At least just one addon-manager, so whenever possible I choose
   Ubuntu packages over Git(Hub) sources.

    ```bash
    apt-get install vim-tabular vim-ctrlp vim-syntastic ultisnips
    vam install vim-tabular vim-ctrlp vim-syntastic ultisnips
    ```



dotfiles
--------

1. Run makesymlinks.sh:

    ```bash
    ~/dotfiles/makesymlinks.sh
    ```
