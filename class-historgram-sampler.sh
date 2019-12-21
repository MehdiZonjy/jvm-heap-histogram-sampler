#! /bin/bash
set -e

usage () {
    echo "Usage: -i <Interval in seconds> -n <Samples Count> -f <Histograms Prefix> <pid>"
}

RGX_NUMERIC='^[0-9]+$'

while getopts "i:n:f:" op; do
    case "${op}" in
        i)
            INTERVAL=${OPTARG}
            if ! [[ $INTERVAL =~ $RGX_NUMERIC ]] ; then
                echo "-i must be positive number"
                usage
                exit 1
                elif [ $INTERVAL -eq 0 ]; then
                echo "-i must be greater than zero"
                usage
                exit 1
            fi
            
        ;;
        n)
            SAMPLES=${OPTARG}
            if ! [[ $SAMPLES =~ $RGX_NUMERIC ]]; then
                echo "-n must be positive number"
                usage
                exit 1
                elif [ $SAMPLES -eq 0 ]; then
                echo "-n must be greater than zero"
                usage
                exit 1
            fi
        ;;
        f)
            PREFIX=${OPTARG}
            if [ -z $PREFIX ]; then
              echo "-f can not be empty"
              usage
              exit 1
            fi
        ;;
        *)
            usage
        ;;
    esac
done

if ((OPTIND == 1))
then
  echo "No options specified"
  usage
  exit 1
fi

shift $((OPTIND - 1))
JVM_PID=$1

if [ -z $JVM_PID ] || [ -z $PREFIX ] ||  [ -z $INTERVAL ] || [ -z $SAMPLES ]; then
  usage
  exit 1
fi

i=0
while [ $i -lt $SAMPLES ]
do
  echo "Captuing Sample $i of $SAMPLES..."
  jmap -histo $JVM_PID > "${PREFIX}-${i}.histo"
  echo "Sleep for $INTERVAL seconds..."
  sleep $INTERVAL
  i=$((i + 1))
done

echo "Creating archieve ${PREFIX}.tar.gz"
find . -name "*.histo" | tar -czf "$PREFIX.tar.gz" -T -
