CREATE DATABASE catalog_of_things;

CREATE TABLE book (
    id INTEGER PRIMARY KEY,
    publisher VARCHAR(100),
    publish_date DATE,
    cover_state VARCHAR(100),
    item_id INTEGER,
    FOREIGN KEY (item_id) REFERENCES item (id)
);

CREATE TABLE label (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    color VARCHAR(150)
);

CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    label_id INTEGER,
    publish_date DATE,
    archived BOOLEAN,
    FOREIGN KEY (label_id) REFERENCES label (id)
);

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  author_id INTEGER REFERENCES authors(id),
  publish_date DATE,
  archived BOOLEAN DEFAULT false
);

CREATE TABLE games (
  id INTEGER PRIMARY KEY REFERENCES items(id),
  multiplayer BOOLEAN NOT NULL,
  last_played_at TIMESTAMP
);

CREATE INDEX idx_book_item_id ON book(item_id);
CREATE INDEX idx_item_label_id ON item(label_id);


CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    published_date DATE,
    item_id INTEGER REFERENCES item(id) ON DELETE CASCADE
);

CREATE TABLE music_albums (
    id SERIAL PRIMARY KEY,
    on_spotify BOOLEAN,
    published_date DATE,
    item_id INTEGER REFERENCES item(id) ON DELETE CASCADE
);
