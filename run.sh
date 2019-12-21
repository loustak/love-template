pwd=$(pwd)
basename=$(pwd)
cd ../
while true; do
  find $basename | entr -c -d -r love $basename
done
