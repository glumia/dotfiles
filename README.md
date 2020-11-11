# dotfiles
*You can't know when the cup of tea will fall on your laptop.*

#### Why a public repository for dotfiles
Almost all of my configs were built taking pieces of other people's dotfiles here
and there. By sharing my personal configuration files I can give back to the 
community a bit of the knowledge I acquired in this process and also have the
opportunity to receive feedbacks.


#### Main sources of inspiration
- [Drew DeVault's dotfiles](https://git.sr.ht/~sircmpwn/dotfiles) (if you don't
  know him take a look at his blog!)
- [*The Missing Semester of Your CS Education* professors'
  .vimrc](https://missing.csail.mit.edu/2020/editors/)
- [Arch Wiki](https://wiki.archlinux.org/)
- [Global .gitignore](https://gist.github.com/subfuzion/db7f57fff2fb6998a16c)


#### Hint
```
gius@whitewolf:~$ rm .bashrc ; ln -s dotfiles/.bashrc-debian .bashrc
```

Keep your dotfiles in a version controlled folder like this one and in your home
directory create symbolic links for them. In this way whenever you change a
config file in your home you'll have the change ready to be committed and pushed
to your dotfiles repository. Viceversa, if you work on multiple computers and
updated a config file on a different one than your current machine all you need 
to  have the latest configuration is a `git pull` in the dotfiles directory.

