# dotfiles

Collection repository of my dotfiles

## Usage

```shell
# Clone dotfiles under home directory
$ cd
$ git clone git@github.com:iwamura-lab/dotfiles.git

# Create symbolic links
# zsh
$ ln -s ~/dotfiles/.zshenv ~
$ ln -s ~/dotfiles/.zshrc ~
$ ln -s ~/dotfiles/.zprofile ~
$ ln -s ~/dotfiles/.zsh_aliases ~

# git
$ ln -s ~/dotfiles/.gitconfig ~
$ ln -s ~/dotfiles/git/.gitignore ~

# tmux
$ ln -s ~/dotfiles/.tmux.conf ~
```

### Vim
```
ln -s ~/dotfiles/.vimrc ~ \
&& git clone git@github.com:joshdick/onedark.vim.git ~/.vim/pack/dist/opt/onedark.vim \
&& git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/dist/start/vim-polyglot \
&& git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
```


# On Mac with Alacritty
$ ln -s ~/dotfiles/.alacritty.yml ~
```
