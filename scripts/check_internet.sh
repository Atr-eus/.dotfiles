#!/bin/bash

wget -q --spider 1.1.1.1

if [[ $? -eq 0 ]]; then
  echo "🟢Online"
else
  echo "🔴 Offline"
fi
