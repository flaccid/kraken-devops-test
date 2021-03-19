# Text Processing Exercise

Sample data is taken from https://www.briandunning.com/sample-data/ (fake data).

Comma-delimited per line records of:
- First Name
- Last Name
- Company
- Address
- City
- County (where applicable)
- State/Province (where applicable)
- ZIP/Postal Code
- Phone 1
- Phone 2
- Email
- Web

The text manipluation excercise:
1. Grab the data into a variable/object, ignore the header line
2. Cut the data down to the first 20 records
3. Remove the `company_name` field from each record
4. Save to a new file named `us-20-nocompany.csv`

## Solutions

 - Script kiddy using shell binaries - [`sc.sh`](./sc.sh)
 - `TODO`: Advanced script kiddy using POSIX/sh - [`sca.sh`](./sca.sh)
 - Grown-up using a simple golang program (note that https://golang.org/pkg/encoding/csv/ does not yet support writing with quoted field encapsulation) - [`gu.go`](./gu.go)
