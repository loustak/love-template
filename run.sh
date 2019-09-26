pwd=$(pwd)
basename=$(pwd)
cd ../
while true; do
  ls $pwd/*.lua | entr -c -d -r love $basename
done