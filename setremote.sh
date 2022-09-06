#!/bin/bash

git remote -v

#prot=https
prot=git

git remote set-url origin $prot@github.com:nhsdigitalmait/SPINE_EPS_Tester.git

git remote -v
