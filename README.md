#dancer2_sqlite_app_block_table

The goal is to create a lightweight Perl based web app which uses a flat file stucture and which is Docker ready (portable).

-Entries must be 6 fields.
-FIRST entry for every Unique parent must start with "none" as 

  		Parent, Type, Date, Name, AuthorInitials, Note  
parent entry1:1	none	Initiative	03-13-2020	Thing1	PMH	Spider Man 13!!!
entry1:2	Thing1	BLANK	03-13-2020	Thing1	PMH	Still Working 5. Spider Man 13.

parent entry2:1	none	Initiative	03-13-2020	Thing2	PMH	Starting Thing 2.
entry2:2	Thing2	Project	03-14-2020	Thing2	PMH	Starting part 2.
entry2:3		Thing1	BLANK	03-18-2020	Thing1	PMH	Working on this.


-Run it:
 
    sudo /usr/local/bin/plackup bin/app.psgi --port 5005 --host 0.0.0.0



-Paul
