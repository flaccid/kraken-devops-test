#!/bin/bash -e

# get data from file and remove header line
data=$(cat us-500.csv | sed -e '1d')

# re-process removing the company name and redirect to file
# the regex is to support values that have a comma in them
echo "$data" | gawk '
BEGIN {
    FPAT = "([^,]+)|(\"[^\"]+\")"
    count=0
}
{
  if (count < 20) {
    print $1","$2","$4","$5","$6","$7","$8","$9","$10","$11","$12
    ++count
  }
}
' > us-20-nocompany.csv
