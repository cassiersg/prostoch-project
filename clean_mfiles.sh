#! /bin/bash

for filename in matlab/*.m; do
    grep -v "% @" "$filename" > matlab_report/$(basename "$filename")
done

