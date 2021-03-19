package main

import (
	"bufio"
	"encoding/csv"
	"io"
	"os"
)

type Contact struct {
	FirstName   string
	LastName    string
	CompanyName string
	Address     string
	City        string
	County      string
	State       string
	Zip         string
	Phone1      string
	Phone2      string
	Email       string
	Web         string
}

// readCsvToContacts accepts a filename and
// returns all contacts found in the csv minus the header row
func readCsvToContacts(filename string) (contacts []Contact, err error) {
	// get the file contents
	f, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	// skip the first row/line
	firstRow, err := bufio.NewReader(f).ReadSlice('\n')
	if err != nil {
		return nil, err
	}
	_, err = f.Seek(int64(len(firstRow)), io.SeekStart)
	if err != nil {
		return nil, err
	}

	// read the remaining rows
	r := csv.NewReader(f)
	rows, err := r.ReadAll()
	if err != nil {
		return nil, err
	}

	for _, line := range rows {
		contacts = append(contacts, Contact{
			FirstName:   line[0],
			LastName:    line[1],
			CompanyName: line[2],
			Address:     line[3],
			City:        line[4],
			County:      line[5],
			State:       line[6],
			Zip:         line[7],
			Phone1:      line[8],
			Phone2:      line[9],
			Email:       line[10],
			Web:         line[11],
		})
	}

	return contacts, nil
}

// saveContactsToCsv takes an array of contacts and
// saves to the specified filename and row limit
func saveContactsToCsv(contacts []Contact, filename string, limit int) (err error) {
	f, err := os.Create(filename)
	if err != nil {
		return err
	}
	w := csv.NewWriter(f)

	for i := 0; i <= (limit - 1); i++ {
		contact := contacts[i]
		// we ommit the company name column
		line := []string{
			contact.FirstName,
			contact.LastName,
			contact.Address,
			contact.City,
			contact.County,
			contact.State,
			contact.Zip,
			contact.Phone1,
			contact.Phone2,
			contact.Email,
			contact.Web,
		}
		err := w.Write(line)
		if err != nil {
			return err
		}
	}

	w.Flush()

	return nil
}

func main() {
	contacts, err := readCsvToContacts("./us-500.csv")
	if err != nil {
		panic(err)
	}

	err = saveContactsToCsv(contacts, "./us-20-nocompany.csv", 20)
	if err != nil {
		panic(err)
	}
}
