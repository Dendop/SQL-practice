"""
Import took nearly 15 mins for csv data due to
data missmatch I was not aware of, I used in temp_table "crime_id" primary key autoincrement
that is not matching csv header therefore the import was slow and inaccurate
Not needed
"""


import csv
input_file = 'chicago_crime_2023.csv'
output_file = 'chicago_crime_2023_subset.csv'

with open(input_file, mode = 'r', encoding = 'utf-8') as infile:
    csvreader = csv.reader(infile)
    
    header = next(csvreader)
    
    with open(output_file, mode = 'w', newline = '', encoding = 'utf-8') as outfile:
        csvwriter = csv.writer(outfile)
        
        csvwriter.writerow(header)
        
        for i,row in enumerate(csvreader):
            if i >= 2500: #stop
                break
            csvwriter.writerow(row)
            
print("Subset has been created")