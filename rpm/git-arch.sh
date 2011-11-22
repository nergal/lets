#!/bin/bash
TMP=$1
NV=$2
BASEPATH=`git rev-parse --show-prefix`

export NV TMP BASEPATH

git archive --format=tar --prefix="${NV}/" --output="${TMP}/${NV}.tar" HEAD
cd `git rev-parse --show-cdup`
# git submodule foreach 'FNAME=`mktemp -p /tmp rpmtarXXXXXX`;git archive --format=tar --output=$FNAME --prefix=${NV}/`echo ${path} | sed -e "s#$BASEPATH##"`/ $sha1;tar -Af "${TMP}/${NV}.tar" $FNAME;rm $FNAME'
