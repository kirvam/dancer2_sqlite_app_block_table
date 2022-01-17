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
