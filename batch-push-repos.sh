#!/bin/bash

for REPO in bronze-java-level-1 bronze-java-level-3 bronze-java-sim-level-2 bronze-js-level-3 bronze-js-sim-level-3 empty-java-with-test empty-js-with-test html-homework java-language-basic-part-1 java-language-basic-part-2 java-language-basic-self-test js-language-basic silver-java-level-1 silver-js-level-1 silver-js-level-2 silver-js-level-3 stone-java-env-verify
do
    (
        cd $REPO
        local remote_url=$(git remote -v | tr '\t' ' ' | tr -s ' ' | cut -d' ' -f2 | head -n1)
        git remote set-url origin $(echo $remote_url | sed 's/mengyuan/mengyuan1/')
        git push origin master
    )
done

