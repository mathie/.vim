# My Vim stuff

It would appear that I'm looking to use a bunch of plugins for Vim in order to
make it usable for Rails development. I've already lost track of all the bits
I've downloaded, where they're from and how I keep them up to date. So how
about some git loving? The idea here is to have the necessary plugins as git
submodules that I can update as necessary. But it's also to keep everything
separated so I can individually update plugins as required.

## Usage

There are two parts to this repository:

* The set of plugins grabbed from various Git repositories and zip files around
  the Interwebs.

* My `vimrc` file.

To use the plugins, shift the entire project across to `~/.vim` or symlink
`~/.vim` to where you checked out this repository.  For example:

    $ cd ~/src
    $ git clone git://github.com/mathie/.vim mathie-vim
    $ cd mathie-vim
    $ git submodule init
    $ git submodule update
    $ cd
    $ rm -rf .vim
    $ ln -s ~/src/mathie-vim .vim

Bingo. You'll have this thing checked out somewhere sensible, but still have it
in the right place for Vim to pick it up.

To pick up the `vimrc` file too, do something along the lines of:

    $ cd
    $ ln -snf .vim/vimrc .vimrc

And you'll have the vimrc file symlinked into the right place. Note that both
of these operations are destructive and WILL REMOVE ALL YOUR EXISTING VIM
CONFIGURATION. But you noticed that already, right? ;-)

## Updating the plugins

If you're looking to update all the plugins to the latest version, you'll want
to do something along the lines of:

    $ cd ~/.vim
    $ rake update

That will pull down the latest versions of all the git repositories, and redo
the symlinks so all the latest files are linked up.

## Copyright and license

Frankly, none of the stuff in here is mine -- it's all publicly available
plugins written by other Vim developers and users. I've just pulled it together
and added a bit of glue. What belongs to others belongs to others and its up to
them to license it and up to you to obey the license. The Rakefile that glues
'em together is under the public domain. Enjoy.
