#!/bin/bash

# Gets the absolute path for this script
src_dir=$( cd "$( dirname "${0}" )" && pwd )

read -p "About to remove dotfiles symlinked from ${src_dir} to ${HOME}. Do you want to continue? [y/n] " -e response

if [[ ${response} != "y" ]]
then
    echo "Exiting..."
    exit 1
fi

# symlink must be a "dotfile"
for file in ${HOME}/.*
do
    # File must exist
    if [ ! -e ${file} ]
    then
	continue
    fi

    # File must be a symlink
    if [ ! -h ${file} ]
    then
	continue
    fi

    # Only remove symlinks to the dotfiles
    src_file=`readlink ${file}`
    found=`expr "${src_file}" : "${src_dir}"`
    if [ ${found} -eq 0 ]
    then
        continue
    fi

    echo "Removing symlink: ${file}"
    rm ${file}
done

echo "Finished"
