duration=1200
echo "sleep $((duration/4)) && kubectl top po --containers -A > /resources-$((duration/4/60))min.txt"