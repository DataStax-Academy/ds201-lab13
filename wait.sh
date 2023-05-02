#!/usr/bin/env bash

clear
echo " ██████╗  █████╗ ████████╗ █████╗ ███████╗████████╗ █████╗ ██╗  ██╗ "
echo " ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗╚██╗██╔╝ "
echo " ██║  ██║███████║   ██║   ███████║███████╗   ██║   ███████║ ╚███╔╝  "
echo " ██║  ██║██╔══██║   ██║   ██╔══██║╚════██║   ██║   ██╔══██║ ██╔██╗  "
echo " ██████╔╝██║  ██║   ██║   ██║  ██║███████║   ██║   ██║  ██║██╔╝ ██╗ "
echo " ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ "
echo ""

echo -n 'Preparing your environment ...'; 
timeout 120 bash -c 'until ./node1/bin/cqlsh -e "describe cluster" >/dev/null 2>&1; do sleep 2; echo -n "."; done';
timeout 120 bash -c 'until ./node2/bin/cqlsh -e "describe cluster" >/dev/null 2>&1; do sleep 2; echo -n "."; done';
timeout 120 bash -c 'until ./node3/bin/cqlsh -e "describe cluster" >/dev/null 2>&1; do sleep 2; echo -n "."; done';
echo ' DONE!'
echo "Environment ready."
echo ""