CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE toys (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  dog_id INTEGER,

  FOREIGN KEY(dog_id) REFERENCES dog(id)
);


INSERT INTO
  toys (id, name, dog_id)
VALUES
  (1, "Bone", 4),
  (2, "Baseball", 2),
  (3, "Slipper", 3),
  (4, "Heel", 4),
  (5, "Blue Bouncy Ball", 1),
  (6, "Red Bouncy Ball", 2),
  (7, "Bone", 1);

INSERT INTO
  humans (id, fname, lname)
VALUES
  (1, "Lily", "Andrews"),
  (2, "Thomas", "Smith"),
  (3, "Grace", "Moore"),
  (4, "Dogless", "Human");

INSERT INTO
  dogs (id, name, owner_id)
VALUES
  (1, "Bailey", 1),
  (2, "Luna", 2),
  (3, "Baxter", 3),
  (4, "Charlie", 3),
  (5, "Stray Dog", NULL);
