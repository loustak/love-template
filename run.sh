pwd=$(pwd)
cd ../
while true; do
  ls $pwd/*.lua | entr -c -d -r love cadence
done
