#!/bin/bash


set -e
script_dir=$(dirname "$0")
# Change directory to make sure logs directory is created inside $script_dir
cd "$script_dir"

test_name="cpu-1"
heap_size="1g"
duration=1200
ingress_host=
remote_hosts=""

declare -a user_counts_array=(1000 500 200 100 50 10)
declare -a payloads_array=("102400B" "10240B" "1024B" "50B")

# declare -a user_counts_array=(1000)
# declare -a payloads_array=("102400B")


function usage() {
    echo ""
    echo "Usage: "
    echo "$0 [-n test_name>] [-r <remote_hosts>] [-i <ingress_host>]"
    echo ""
    echo "-n: Test Name."
    echo "-r: Remote Servers."
    echo "-i: Ingress Host."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "n:r:i:d:h" opts; do
    case $opts in
    n)
        test_name=${OPTARG}
        ;;
    r)
        remote_hosts=${OPTARG}
        ;;
    i)
        ingress_host=${OPTARG}
        ;;
    d)
        duration=${OPTARG}
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    esac
done

if [[ -z $remote_hosts ]]; then
    echo "Please specify remote hosts."
    exit 1
fi

mkdir -p "${HOME}/reports/"

# Run Test
for user_count in "${user_counts_array[@]}"; do
    for payload_size in "${payloads_array[@]}"; do
        echo "#############################################################"
        echo "Users Count: $user_count"
        echo "Payload Size: $payload_size"

        results_dir="${HOME}/results/${test_name}/passthrough/${heap_size}_heap/${user_count}_users/${payload_size}/0ms_sleep"
        echo "Results Dir: ${results_dir}"
        cd $results_dir
        cat results-measurement-summary.json
    done
done




