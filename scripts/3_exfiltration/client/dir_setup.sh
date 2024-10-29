#!/bin/bash

# Sets up a mock file system for the sake of testing/demonstrating

if [ -d clientfs ]; then
    rm -rf clientfs
fi

mkdir clientfs
cd clientfs
echo "teststr" > othershit.txt

mkdir dir1 dir2 assignments myfiles

cd myfiles
echo "teststr" > unimportant.txt
echo "teststr" > assignment_answers.txt
cd ..

cd assignments
echo "teststr" > 123.txt
cd ..

cd dir2
mkdir comp1234
echo "teststr" > comp9999.txt
echo "teststr" > asst1.txt

cd comp1234 
echo "may you find your worth in the waking world" > ass1.txt
cd ..
cd ..

cd dir1
mkdir COMP6969
cd COMP6969
echo "rizzing fundamentals" > assignment4.txt
cd ..
mkdir comp1313
cd comp1313
echo "pee peepoopoo" > lab1.txt

