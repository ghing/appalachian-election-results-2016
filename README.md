Appalachian 2016 Presidential Election Results
==============================================

These are some data processing scripts to get election results shared by the Daily Yonder into a shape that can be imported into [Carto](https://carto.com) and joined with this [GeoJSON file of Appalachian counties](https://github.com/ghing/appalachia) in order to create an elections choropleth.

These scripts fix a couple of issues with the data:

* Less-common Latin 3 encoding instead of UTF-8
* Numeric values are quoted and have a literal "," in them
* FIPS code should be interpretted as text in Carto
* Some columns don't have column labels
* There are lots of columns that we don't care about
* There are rows for every county in the U.S., not just Appalachia

Processing the data
-------------------

You'll need to install this software to run it on your computer.  Instuctions for that are TK.

For now, this is how you generate the "clean" CSV file from the original:

    make

The heavy lifting in the [Makefile](https://en.wikipedia.org/wiki/Makefile) is done with this shell command:

    csvcut -e latin3 -c 1,2,"FIPS","Total Vote",14,15 Pres_Election_Data_2016n.csv | csvgrep -c 2 -r "AL|PA|TN|NY|GA|SC|MS|KY|NC|MD|VA|OH|WV" | ./fix_column_types_and_rename.py > Pres_Election_Data_2016n__appalachia.csv

This command uses the shell's [pipe operator](https://en.wikipedia.org/wiki/Pipeline_(Unix)) to send CSV data between a number of small commands.

Let's walk through the different pieces.

First, read in source file, properly interpretting its encoding and select only the county name, state abbreviation, FIPS code, total votes, Clinton votes and Trump votes columns:

     csvcut -e latin3 -c 1,2,"FIPS","Total Vote",14,15 Pres_Election_Data_2016n.csv

Note that we use the column indices (which you could find with `csvcut -n Pres_Election_Data_2016n.csv`) for the county name and state abbreviation columns because they don't have column headers.  We use the column indices for the Clinton and Trump votes because because multiple columns have the labels "Clinton" and "Trump".

Then, filter the rows to only results for Appalachian states:

    csvgrep -c 2 -r "AL|PA|TN|NY|GA|SC|MS|KY|NC|MD|VA|OH|WV"

Add column names for the columns that don't have labels and make sure numbers don't have commas in them in the CSV:

    ./fix_column_types_and_rename.py

This is a custom script that uses [Agate](https://agate.readthedocs.io) to do the heavy lifting.

Finally, save the output using `>` to redirect standard output to a file:

    > Pres_Election_Data_2016n__appalachia.csv

Uploading the data to Carto
---------------------------

We can then upload this file to Carto.  However, we need to uncheck the option that tells Carto to try to guess the column types when uploading the file.  After uploadting, we'll have to manually switch the vote result columns from text to numeric in the Carto interface.

Adding calculated columns
-------------------------

I made the choice to only upload data with the raw values needed to calculate other things: the total votes, Clinton votes and Trump votes.  Then, I used a SQL query in the Carto interface to add the derivative columns.  You can copy and paste the query from `add_calculated_columns.sql`.  I could have also done this in a Python script with Agate if I wanted to calculate values before uploading. 

Joining with the county boundaries
----------------------------------

I had already uploaded a GeoJSON file of Appalachian counties to Carto.  To join it with the election results, I used the query in `join_tables.sql`.  After I ran the query in Carto, I was abe to save the joined data as a new dataset that I could use to make the map. 
