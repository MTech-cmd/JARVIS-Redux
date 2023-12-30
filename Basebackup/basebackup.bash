source_dir="/home/mtech/bit-academy"
destination_dir="/home/mtech/Projects/Bit-Academy"
exclude_folder=".git"

cd "$destination_dir";

if [ ! -d "$source_dir" ]; then
    echo "Source directory not found."
    exit 1
fi

if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
fi

rsync -av --delete --exclude="$exclude_folder" "$source_dir"/ "$destination_dir"
echo "Files and directories copied from $source_dir to $destination_dir"

function recursive_for_loop { 
    ls -1| while read f; do
        if [ -d $f  -a ! -h $f ];  
        then  
            cd -- "$f";  
            echo "Deleting git folder in `pwd`/$f";
            rm -rf .git

            recursive_for_loop;
            cd ..; 
        fi;  
    done;  
};
recursive_for_loop;
echo "Pushing to GitHub";
git add .;
git commit -m "backed up using basebackup";
git push;
echo "Basebackup finished";
