# User specific aliases and functions

# a custom auto-complete that is really slow...
#if [ -e /etc/bash_completion ]; then
#	. /etc/bash_completion
#fi

export LANG="en_US.utf8"

# enable hostname tab completion for certain commands
export HOSTFILE=~/.hosts
complete -A hostname ssh ping telnet

# enable coredumps
# Also, see ~/enableCoreDumps.sh
#ulimit -c 50000 # 50 megs
ulimit -c unlimited # we don't fill up the disk now... will we?

export EDITOR=emacs

# loads emacs w/ vertical windows (ie you split/cut into 2 horizontal pieces)
alias emacsv='emacs -f split-window-horizontally'

# export PATH=/usr/local/bin:$PATH

# sets how much info I get when I run make
export MAKE_OUTPUT_LEVEL=QUIET #options: NORMAL, QUIET, DEBUG, VERBOSE


# sets my prompts up
PS1="[\h:\W]$ "
PS2="> "
#if [ `hostname` = "hsl-dev-0" "Dale-Huis-MacBook-Pro.local"]
#then
#    PS1="[\W]\$ "
#    PS2="> "
#else
#    if [ `hostname | grep desktop` ]
#    then
#        PS1="[\h]\$ "
#        PS2="> "
#    fi
#fi

# Changes the length of my history in bash
HISTSIZE=99999999

# prints the date in a certain format
alias datestring='date +%Y-%m-%d.%H.%M.%S'

# locks the screen (like a screensaver)
alias lock='xscreensaver-command -lock'

# makes grep highlights the match
alias grep='grep --color=auto'

# makes ls highlight directories and executables
case $OSTYPE in
    linux*)
        alias ls='ls --color=auto'
        ;;
    darwin*)
        export CLICOLOR=1

        # Other Mac OS X specific config

        # Setting PATH for MacPython 2.6
        # The orginal version is saved in .bash_profile.pysave
        PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
        export PATH

        # Setting PATH for MacPython 2.6
        # The orginal version is saved in .bash_profile.pysave
        PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
        export PATH

        # Setting PATH for Python 2.7
        # The orginal version is saved in .bash_profile.pysave
        PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
        export PATH

        # Setting PATH for Ruby 1.9.3
        # The orginal version is saved in .bash_profile.pysave
        PATH="/usr/local/Cellar/ruby/1.9.3-p362/bin:${PATH}"
        export PATH
        ;;
esac

# makes bc preload the math libraries and sets the scale to 20
export BC_ENV_ARGS=-l

# emacs diff mode
alias ediff='emacs -diff'

# setup perforce environment
export P4CONFIG=.p4config
export P4EDITOR=emacs
export P4DIFF="emacs -diff"

# gets all pending perforce changelists for the current user
alias changelists='p4 changes -s pending -u $USER -t -l'

# gets the last 10 submitted changes
alias submittedchanges='p4 changes -s submitted -u $USER -t -l -m 10'

# gets the current cln for a workspace
alias currentcln='p4 changes -m1 -l -t @`p4 client -o | grep ^Client | cut -f 2`'

# finds files that you haven't added into perforce yet
# p4 files * | grep "no such"
alias unadded='find . -type f | p4 -x - have > /dev/null'

# grep only for .cpp and .h files recursively
# grep -rHn --include=*.{cpp,h} -e "MY_PATTERN" *

# setup ssh key forwarding for screen
if [ -e ~/.screen/session-variables ]; then
  alias ssh='source ~/.screen/session-variables; ssh'
fi

if [ -e ~/.screen/setup_session_vars.sh ]; then
  alias screen='~/.screen/setup_session_vars.sh; screen'
fi

# renames in perforce http://kb.perforce.com/UserTasks/ManagingFile..Changelists/RenamingFiles
function p4rename
{
    old=$1
    new=$2
    p4 integrate $old $new
    p4 delete $old
}

# shows a summary of the p4 diff
function p4diffsummary
{
    p4DiffFile=/tmp/p4diffsummary
    unset P4DIFF; p4 diff -ds > /tmp/p4diffsummary
    addLines=`cat $p4DiffFile | grep add | awk '{sum += $4} END {print sum}'`
    deletedLines=`cat $p4DiffFile | grep deleted | awk '{sum += $4} END {print sum}'`
    changedOldLines=`cat $p4DiffFile | grep changed | awk '{sum += $4} END {print sum}'`
    changedNewLines=`cat $p4DiffFile | grep changed | awk '{sum += $6} END {print sum}'`
    newMinusOld=$(( $changedNewLines - $changedOldLines ))
    echo Added $addLines lines
    echo Deleted $deletedLines lines
    echo Changed lines: old: $changedOldLines new: $changedNewLines newMinusOld: $newMinusOld
    totalLinesAdded=$(( $addLines - $deletedLines + $newMinusOld ))
    echo Total lines added: $totalLinesAdded
    echo
    echo See $p4DiffFile for raw perforce output
}

# finds lines that are longer than specified
# example: "findLongLines 80 *" will find all lines in files longer than 80 characters
function findLongLines
{
    maxLines=$1
    shift
    for filename in $@
    do
        # prints the line_length, filename:line_number the line itself
        awk "{if (length > $maxLines) printf(\"%d %s:%d %s\\n\",length,FILENAME,NR,\$0);}" $filename
    done
}

function backup
{
    file=$1
    cp $file $file.bk
}

function restore
{
    file=$1
    cp $file.bk $file
}

# initializes the cross-ref searching in emacs using cscope
# assumes that .emacs is setup correctly with cscope
function initCscopeDb
{
    dir=`pwd | cut -f -4 -d '/'`
    cscope-indexer -r $dir
}

# Source local bash profile
if [ -f ~/.bash_profile.local ]; then
        . ~/.bash_profile.local
fi
