
#!/bin/bash -e
#
# Updates Vim plugins.
#
# Update everything (long):
#
#   ./installVimPlugins
#
# Update just the things from Git:
#
#   ./installVimPlugins repos
#
# Update just one plugin from the list of Git repos:
#
#   ./installVimPlugins repos powerline
#

vimdir=~/.vim
bundledir=$vimdir/bundle
tmp=/tmp/$LOGNAME-vim-update
me=~/.vim/installServerVimPlugins.sh

# URLS --------------------------------------------------------------------

# This is a list of all plugins which are available via Git repos. git:// URLs
# don't work.
repos=(
  https://github.com/ap/vim-css-color.git
  https://github.com/kien/ctrlp.vim.git
  https://github.com/pangloss/vim-javascript.git
  https://github.com/scrooloose/nerdtree.git
  https://github.com/scrooloose/syntastic.git
  https://github.com/tpope/vim-markdown.git
  https://github.com/tpope/vim-pathogen.git
  https://github.com/tpope/vim-surround.git
  https://github.com/mattn/emmet-vim/
  https://github.com/jistr/vim-nerdtree-tabs.git
  https://github.com/ervandew/supertab.git
  https://github.com/tomtom/tcomment_vim.git
  https://github.com/jlangston/tomorrow-night-vim.git
  https://github.com/terryma/vim-multiple-cursors.git
  )

# Here's a list of everything else to download in the format
# <destination>;<url>[;<filename>]
other=()

case "$1" in

  # GIT -----------------------------------------------------------------
  repos)
    mkdir -p $bundledir
    for url in ${repos[@]}; do
      if [ -n "$2" ]; then
        if ! (echo "$url" | grep "$2" &>/dev/null) ; then
          continue
        fi
      fi
      dest="$bundledir/$(basename $url | sed -e 's/\.git$//')"
      rm -rf $dest
      echo "Cloning $url into $dest"
      git clone $url $dest
      rm -rf $dest/.git
    done
    ;;

  # TARBALLS AND SINGLE FILES -------------------------------------------
  other)
    set -x
    mkdir -p $bundledir
    rm -rf $tmp
    mkdir $tmp
    pushd $tmp

    for pair in ${other[@]}; do
      parts=($(echo $pair | tr ';' '\n'))
      name=${parts[0]}
      url=${parts[1]}
      filename=${parts[2]}
      dest=$bundledir/$name

      rm -rf $dest

      if echo $url | egrep '.zip$'; then
        # Zip archives from VCS tend to have an annoying outer wrapper
        # directory, so unpacking them into their own directory first makes it
        # easy to remove the wrapper.
        f=download.zip
        $curl -L $url >$f
        unzip $f -d $name
        mkdir -p $dest
        mv $name/*/* $dest
        rm -rf $name $f

      else
        # Assume single files. Create the destination directory and download
        # the file there.
        mkdir -p $dest
        pushd $dest
        if [ -n "$filename" ]; then
          $curl -L $url >$filename
        else
          $curl -OL $url
        fi
        popd

      fi

    done

    popd
    rm -rf $tmp
    ;;

  # HELP ----------------------------------------------------------------

  all)
    $me repos
    $me other
    echo
    echo "Update OK"
    ;;

  *)
    set +x
    echo
    echo "Usage: $0 <section> [<filter>]"
    echo "...where section is one of:"
    grep -E '\w\)$' $me | sed -e 's/)//'
    echo
    echo "<filter> can be used with the 'repos' section."
    exit 1

esac
