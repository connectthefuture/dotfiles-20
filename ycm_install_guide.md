Condensed Installation Guide
----------------------------

1.  **Install YCM** with Vundle
    Add `Plugin 'Valloric/YouCompleteMe'` line to your vimrc.
    Then run :PluginInstall in Vim.

2.  [Complete this step ONLY if you care about semantic completion support for
    C-family languages. Otherwise it's not neccessary.]

    **Download the latest version of `libclang`**. 
    - Download a binary distribution of LLVM+Clang from llvm.org.
    - Extract to folder `~/ycm_temp/llvm_root_dir`
      (with `bin`, `lib`, `include` etc. folders right inside that folder). 

3.  **Compile the `ycm_support_libs` libraries** that YCM needs.

    apt-get install cmake python-dev
    
    cd ~ && mkdir ycm_build && cd ycm_build
    
    cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/dotfiles/vim/bundle/YouCompleteMe/third_party/ycmd/cpp
    
    make ycm_support_libs
