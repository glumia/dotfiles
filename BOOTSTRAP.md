Personal reminder of steps to 'bootstrap' a new computer/distro.

# 0. Backup home files
Check files of `~` I don't want to lose and backup them (cp -a) on another partition/device. 

# 1. Install Unix OS (Debian, Ubuntu, ElementaryOS, MacOS, OpenBSD, whatever)

# 2. Recover files of step 0.

# 3. Install preferred software 
This could be scripted in the future depending on the particular OS (eg. on distros with `apt`).

List of favourite GUI software/packages:
- Firefox (remember to execute the login)
- Wireshark
- KeepassXC
- GParted
- pyenv (this could be scripted)
- PyCharm (also this could be scripted)

TODO: Add list of favourite tools (eg. pyenv, etc)


# 4. Re-create dev userland (IDE and terminal env)
## 0. Install [Brew](https://brew.sh) (**only for MacOS**)

## 1. Setup GPG secret key
You know where you keep your private key. Get it, then:
```
gpg --import private.key
```

## 2. Install Emacs (debian-specific guide)
### 1. Install Doom pre-requisites
- Git (upstream)
  ```
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt update
  sudo apt install git
  ```
- [Ripgrep](https://github.com/BurntSushi/ripgrep/releases) (`dpkg -i filename.deb`)
- [fd](https://github.com/sharkdp/fd/releases)
- `sudo apt install pandoc` (needed for markdown live preview)
- `sudo apt install shellcheck` (needed for sh linting)

### 2. Manual compilation
- Enable apt source repositories (/etc/apt/sources.list)
- `sudo apt-get build-deps emacs25` (or the other most recent version on apt)
- `sudo apt install libjansson-dev` (otherwise emacs will be compiled with slow json parsing capabilities)
- Clone emacs repository (take care to clone the branch you want to build!) 
- `sh autoconfig.sh && ./configure --with-json && make && sudo make install`

### 2.1 Apply ElementaryOS patch (optional)
Alias `emacs` to `XLIB_SKIP_ARGB_VISUALS=1 emacs`

### 3. Install [Doom](https://github.com/hlissner/doom-emacs)

## 3. Install dotfiles
```
sh install.sh
```
