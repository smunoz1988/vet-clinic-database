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

/* Create a table named owners with the following columns: id: integer (set it as autoincremented PRIMARY KEY), full_name: string, age: integer */

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(50) NOT NULL,
    age int NOT NULL
);

/* Create a table named species with the following columns: id: integer (set it as autoincremented PRIMARY KEY), name: string */

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL
);

/* Modify animals table: Make sure that id is set as autoincremented PRIMARY KEY (already DONE when the table was created), 
Remove column species, Add column species_id which is a foreign key referencing species table, 
Add column owner_id which is a foreign key referencing the owners table */

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int REFERENCES species(id);
ALTER TABLE animals ADD owner_id int REFERENCES owners(id);

/* Create a table named vets with the following columns: id: integer (set it as autoincremented PRIMARY KEY), name: string, age: integer, date_of_graduation: date */

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL,
    age int NOT NULL,
    date_of_graduation date NOT NULL
);

/* There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship. */

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    vet_id int REFERENCES vets(id),
    species_id int REFERENCES species(id)
);

/* There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    vet_id int REFERENCES vets(id),
    animal_id int REFERENCES animals(id),
    date_of_visit date NOT NULL
);
