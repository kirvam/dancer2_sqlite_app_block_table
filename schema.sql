create table if not exists entries (
    id integer primary key autoincrement,
    parent string not null,
    entryDate string not null,
    category string not null, 
    title string not null,
    text string not null,
    status string not null
  );

create table if not exists db_entries (
    id integer primary key autoincrement,
    parent string not null,
    entryParent string not null,
    entryType string not null,
    handDate string not null, 
    entryTitle string not null,
    authorName string not null,
    textNote string not null,
    sqlDate text
  );

