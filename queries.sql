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

/*require queries on update animals table */

/* How many animals are there? */

SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */

SELECT AVG(weight) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */

SELECT species, MIN(weight), MAX(weight) FROM animals GROUP BY species;

/* What is the average number of escape attempts per species of those born between 1990 and 2000? */

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* QUERY MULTIPLE TABLES: Write queries (using JOIN) to answer the following questions: */

/* What animals belong to Melody Pond? */

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon) */

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animals. */

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id ORDER BY owners.full_name;

/* How many animals are there per species? */

SELECT species.name, COUNT(animals.id) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* owner name who owns the most animals */

SELECT owners.full_name FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.id) DESC LIMIT 1;

/* Write queries to answer the following: */

/* Who was the last animal seen by William Tatcher? */

SELECT animals.name FROM animals WHERE id = (SELECT animal_id FROM visits WHERE vet_id = 1 ORDER BY date_of_visit DESC LIMIT 1);

/* How many different animals did Stephanie Mendez see */

SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vet_id = 3;

/* List all vets and their specialties, including vets with no specialties */

SELECT vets.name, specializations.species_id FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets */

SELECT animals.name, COUNT(visits.animal_id) FROM animals LEFT JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

/* what animal was Maisy Smith's first visit */

SELECT a.name, v.date_of_visit FROM animals a JOIN visits v ON v.animal_id = a.id JOIN vets ON v.vet_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY v.date_of_visit ASC LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit */

SELECT animals.name, vets.name, visits.date_of_visit FROM animals LEFT JOIN visits ON animals.id = visits.animal_id LEFT JOIN vets ON visits.vet_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species */

SELECT COUNT(*) FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets ve ON v.vet_id = ve.id LEFT JOIN specializations s ON ve.id = s.vet_id AND a.species_id = s.species_id WHERE s.vet_id IS NULL;

/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/

SELECT s.name AS specialty FROM visits v JOIN animals vc ON v.animal_id = vc.id JOIN vets vt ON v.vet_id = vt.id JOIN species s ON vc.species_id = s.id WHERE vt.name = 'Maisy Smith' GROUP BY s.name ORDER BY COUNT(*) DESC LIMIT 1;


/* database performance audit */

/* Case 1 */

SELECT COUNT(*) FROM visits where animal_id = 4;

/* Solution to improve performance: add index to animal_id column in visits table */

CREATE INDEX animal_id_index ON visits (animal_id);

/* Case 2 */

SELECT * FROM visits where vet_id = 2;

/* Solution to improve performance */

CREATE INDEX vet_clinic ON visits(vet_id, id, animal_id, date_of_visit);

/* Case 3 */

SELECT * FROM owners where email = 'owner_18327@mail.com';

/* Solution to improve performance */

CREATE INDEX owner_email ON owners(email);
