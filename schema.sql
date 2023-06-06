/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts int NOT NULL DEFAULT 0,
    neutered boolean NOT NULL DEFAULT false,
    weight float NOT NULL DEFAULT 0
);

/* Add a column species of type string to your animals table. */
ALTER TABLE animals ADD species varchar(50);
