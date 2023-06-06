/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight BETWEEN 10.4 AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. 
Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Inside a transaction: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. 
Update the animals table by setting the species column to pokemon for all animals that don't have species already set. 
Commit the transaction.
Verify that changes persist after commit.*/

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/* Inside a transaction delete all records in the animals table, then roll back the transaction and verify that the records are back. */

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Inside a transaction: Delete all animals born after Jan 1st, 2022. 
Create a savepoint for the transaction. Update all animals' weight to be their weight multiplied by -1. 
Rollback to the savepoint. Update all animals' weights that are negative to be their weight multiplied by -1. 
Commit transaction and verify that changes persist. */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals_savepoint;
UPDATE animals SET weight = weight * -1;
ROLLBACK TO animals_savepoint;
UPDATE animals SET weight = weight * -1 WHERE weight < 0;
COMMIT;
SELECT * FROM animals;
