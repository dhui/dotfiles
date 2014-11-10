echo 'saving out session vars for screen'
if [ -n "$SSH_CLIENT" ]; then
    mkdir -p "$HOME/.screen"

    # Variables to save
    SSHVARS="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"

    for x in ${SSHVARS} ; do
        (eval echo $x=\$$x) | sed  -e 's/=/="/' -e 's/$/"/' -e 's/^/export /'
    done 1> "$HOME/.screen/session-variables"
fi
