create table if not exists entries (
    id integer primary key autoincrement,
    parent string not null,
    category string not null,
    title string not null,
    text string not null
  );
