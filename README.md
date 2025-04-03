<h2>Chicago Crime and Weather</h2>
<h3>This is a practice project inspired by Jaime M. Shaker </h3>
Github link: https://github.com/iweld
<hr>
I have used SQLite to build a database, to run script called <i>"build_and_import.sql"</i> type <h5>cat build_and_import.sql | sqlite3 crimes.db</h5> -> "crimes.db" can be replaced by any other name you want to give for your database<hr>
<br><i>build_and_import.sql</i> will build your tables and import csv files into them.
Aditionally the script will UPDATE empty values to <i>NULL</i> and at the end DROP's temporary tables.
