#!/bin/bash
#
# Usage:
#   ./run.sh <function name>

set -o nounset
set -o pipefail
set -o errexit

show-mem() {
  local pid=$1
  for i in {1..3}; do
    echo "$pid: $i"
    grep '^Vm' /proc/$1/status
    sleep 0.1
  done
}

# Definitely saves a lot of memory under Python 2.7.  37
# VmPeak:   431708 kB
# vs.
# VmPeak:   146004 kB

compare() {
  local n=100000
  #local n=1000000

  ./demo.py Point $n &
  #show-mem $!
  wait

  ./demo.py PointStruct $n &
  #show-mem $!
  wait
}

"$@"
