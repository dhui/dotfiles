#!/bin/bash

# Gets the absolute path for this script
src_dir=$( cd "$( dirname "${0}" )" && pwd )

read -p "About to set the symlink dotfiles from ${src_dir} to ${HOME}. Do you want to continue? [y/n] " -e response

if [[ ${response} != "y" ]]
then
    echo "Exiting..."
    exit 1
fi

# File must be a dotfile
for file in ${src_dir}/.*
do
    # File must exist
    if [ ! -e ${file} ]
    then
	continue
    fi

    # ignore certain files
    if [[ ${file} == "${src_dir}/." || ${file} == "${src_dir}/.." || ${file} == "${src_dir}/.git" ]]
    then
	continue
    fi
    
    echo "Symlinking ${file}"
    ln -s ${file} ${HOME}
done

echo "Finished"
