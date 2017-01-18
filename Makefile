Pres_Election_Data_2016n__appalachia.csv:  Pres_Election_Data_2016n.csv
	csvcut -e latin3  -c 1,2,"FIPS","Total Vote",14,15 Pres_Election_Data_2016n.csv | csvgrep -c 2 -r "AL|PA|TN|NY|GA|SC|MS|KY|NC|MD|VA|OH|WV" | ./fix_column_types_and_rename.py > Pres_Election_Data_2016n__appalachia.csv

clean:
	rm Pres_Election_Data_2016n__appalachia.csv

