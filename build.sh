#!/usr/bin/env bash

./terraform-linux init
./terraform-linux validate

if [[ $TRAVIS_BRANCH == 'company-A' ]]
then
    ./terraform-linux apply -auto-approve
fi 
