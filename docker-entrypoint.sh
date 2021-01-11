#!/bin/sh
echo "----------------------------------------"
echo "##########  GH CLI @ Docker   ##########"
echo ""
echo "REMARK: the GH CLI command 'gh auth login' does not work with docker."
echo "        Please provide GH_TOKEN in environment."
echo ""
echo "Calling GH CLI with:" 
echo "    >> gh $@"
echo "----------------------------------------"
gh $@
