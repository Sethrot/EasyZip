#!/bin/bash

while true; do

    # Prompt the user for the zip file and destination
    echo "Enter the path to the file:"
    read -e file
    echo "Enter the destination path:"
    read -e destination

    # Check if the $file variable ends with a forward slash
    if [[ $file == */ ]]; then
        # Remove the forward slash from the end of the $file variable   /hom    
        file=${file%/}
    fi
    echo $file

    # Show a menu to choose between zipping and unzipping
    echo "Choose an option:"
    echo "1) Zip"
    echo "2) Unzip"
    read -p "Enter your choice [1-2]: " choice

    # Zip or unzip the file based on the user's choice
    case $choice in
        1)
            pv $file | zip -jr - $file > $destination/${file##*/}.zip
            echo "Zipping complete!"
            ;;
        2)
            dirfile=${file##*/}
            mkdir -p $destination/${dirfile%.*}
            unzip $file -d $destination/${dirfile%.*} | pv -l >/dev/null
            echo "Unzipping complete!"
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac

    # Ask the user if they want to run the script again
    read -p "Run again? [y/n] " run_again
    if [[ $run_again != "y" ]]; then
        break
    fi
done    