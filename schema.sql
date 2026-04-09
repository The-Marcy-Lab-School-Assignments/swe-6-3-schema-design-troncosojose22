-- schema.sql
-- Schema Design Assignment
--
-- Scenario chosen: [Replace this with the letter and name of your scenario]
--
-- Instructions:
--   1. Write \c to connect to your database.
--   2. Write DROP TABLE IF EXISTS statements in reverse dependency order.
--   3. Write CREATE TABLE statements in dependency order (parent tables first).
--      Use REFERENCES other_table(other_table_id) for every foreign key.
--      Use UNIQUE (col1, col2) on your association table's two foreign key columns.
--   4. Seed each table with at least 3 rows of realistic data.
--   5. Run: psql -f schema.sql  (Mac) or  sudo -u postgres psql -f schema.sql  (WSL)
--      Run it a second time to confirm it runs cleanly.

-- ============================================================
-- Step 1: Connect to your database
-- ============================================================
    \c music_db


-- ============================================================
-- Step 2: Drop tables in reverse dependency order
-- (most dependent first, so foreign key constraints aren't violated)
-- ============================================================
DROP TABLE IF EXISTS playlists_songs;
DROP TABLE IF EXISTS playlists;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS artists;


-- ============================================================
-- Step 3: Create tables in dependency order
-- (parent tables first, then tables that reference them)
-- ============================================================
CREATE TABLE artists (
  artist_id   SERIAL  PRIMARY KEY,
  artist_name  TEXT   NOT NULL UNIQUE
);

CREATE TABLE songs (
    song_id SERIAL PRIMARY KEY,
    song_name TEXT NOT NULL,
    artist_id INTEGER REFERENCES artists(artist_id)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE playlists (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name TEXT NOT NULL,
    user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE playlists_songs (
    playlist_song_id SERIAL PRIMARY KEY,
    playlist_id INTEGER REFERENCES playlists(playlist_id),
    song_id INTEGER REFERENCES songs(song_id),
    UNIQUE (playlist_id, song_id)
);


-- ============================================================
-- Step 4: Seed each table with at least 3 rows
-- ============================================================

-- Artists
INSERT INTO artists (artist_name) VALUES
  ('Taylor Swift'),
  ('Kendrick Lamar'),
  ('The Beatles');

-- Songs
INSERT INTO songs (song_name, artist_id) VALUES
  ('Shake It Off', 1),
  ('HUMBLE.', 2),
  ('Let It Be', 3);


INSERT INTO users (username, email) VALUES
  ('john_doe', 'john@example.com'),
  ('jose_tron', 'jose@example.com'),
  ('music_lover', 'music@example.com');


INSERT INTO playlists (playlist_name, user_id) VALUES
  ('Morning Vibes', 1),
  ('Workout Hits', 2),
  ('Chill Mix', 3);


INSERT INTO playlists_songs (playlist_id, song_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);
