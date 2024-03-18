# dotfiles

Collection repository of my dotfiles

## Usage

First, clone dotfiles under home directory.
```shell
cd \
&& git clone git@github.com:iwamura-lab/dotfiles.git
```

### zsh

```shell
ln -s ~/dotfiles/.zshenv ~ \
&& ln -s ~/dotfiles/.zshrc ~ \
&& ln -s ~/dotfiles/.zprofile ~ \
&& ln -s ~/dotfiles/.zsh_aliases ~
```

### Git

```shell
ln -s ~/dotfiles/.gitconfig ~ \
&& ln -s ~/dotfiles/git/.gitignore ~
```

### tmux

Install requirements for tmux-yank. Run following commands and enter "prefix + I".
```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
&& ln -s ~/dotfiles/.tmux.conf ~
```

### Vim

```shell
ln -s ~/dotfiles/.vimrc ~ \
&& git clone git@github.com:joshdick/onedark.vim.git ~/.vim/pack/dist/opt/onedark.vim \
&& git clone --depth 1 https://github.com/sheerun/vim-polyglot ~/.vim/pack/dist/start/vim-polyglot \
&& git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
```

### Starship

1. Install Rust.
2. Install Starship.
3. Run following command.
```shell
mkdir -p ~/.config \
&& ln -s ~/dotfiles/starship.toml ~/.config
```


# On Mac with Alacritty

```shell
ln -s ~/dotfiles/.alacritty.yml ~
```
