#!/bin/bash

current_dir=${0%/*}

read -p "About to set the symlink dotfiles from ${current_dir} to ${HOME}. Do you want to continue? [y/n] " -e response

if [[ ${response} != "y" ]]
then
    echo "Exiting..."
    exit 1
fi

for file in ${current_dir}/.*
do
    # File must exist
    if [ ! -e ${file} ]
    then
	continue
    fi

    # ignore certain files
    if [[ ${file} == "${current_dir}/." || ${file} == "${current_dir}/.." || ${file} == "${current_dir}/.git" ]]
    then
	continue
    fi
    
    echo "Symlinking ${file}"
    ln -s ${file} ${HOME}
done

echo "Finished"
