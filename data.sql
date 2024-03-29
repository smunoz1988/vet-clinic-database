/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight, neutered, escape_attempts)
VALUES
    ('Agumon', '2020-02-03', 10.23, true, 0),
    ('Gabumon', '2018-11-15', 8, true, 2),
    ('Pikachu', '2021-01-07', 15.04, false, 1),
    ('Devimon', '2017-05-12', 11, true, 5);


/* Insert requiered data into animals table. */

INSERT INTO animals (name, date_of_birth, weight, neutered, escape_attempts)
VALUES
    ('Charmander', '2020-02-08', -11, false, 0),
	('Plantmon', '2021-11-15', -5.7, true, 2),
	('Squirtle', '1993-04-02', -12.13, false, 3),
	('Angemon', '2005-06-12', -45, true, 1),
	('Boarmon', '2005-06-07', 20.4, true, 7),
	('Blossom', '1998-10-13', 17, true, 3),
	('Ditto', '2022-05-14', 22, true, 4)
;

/* Insert required data into owners table. */

INSERT INTO owners (full_name, age)
VALUES
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38)
;

/* Insert required data into species table. */

INSERT INTO species (name)
VALUES
	('Pokemon'),
	('Digimon')
;

/* Modify your inserted animals so it includes the species_id value: 
If the name ends in "mon" it will be Digimon, 
All other animals are Pokemon */

UPDATE animals
SET species_id = CASE
	WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
	ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

/* Modify your inserted animals to include owner information (owner_id): Sam Smith owns Agumon, Jennifer Orwell owns Gabumon and Pikachu, Bob owns Devimon and Plantmon, Melody Pond owns Charmander, Squirtle, and Blossom, Dean Winchester owns Angemon and Boarmon */

UPDATE animals
SET owner_id = CASE
	WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
	WHEN name = 'Gabumon' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
	WHEN name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
	WHEN name = 'Devimon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
	WHEN name = 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
	WHEN name = 'Charmander' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHEN name = 'Squirtle' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHEN name = 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHEN name = 'Angemon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
	WHEN name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

/* Insert required data for vets */

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

/* Insert required data for specialties */

INSERT INTO specializations (vet_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (4, 2);

/* Insert the following data for visits:
    Agumon visited William Tatcher on May 24th, 2020.
    Agumon visited Stephanie Mendez on Jul 22th, 2020
    Gabumon visited Jack Harkness on Feb 2nd, 2021
    Pikachu visited Maisy Smith on Jan 5th, 2020
    Pikachu visited Maisy Smith on Mar 8th, 2020
    Pikachu visited Maisy Smith on May 14th, 2020
    Devimon visited Stephanie Mendez on May 4th, 2021
    Charmander visited Jack Harkness on Feb 24th, 2021
    Plantmon visited Maisy Smith on Dec 21st, 2019
    Plantmon visited William Tatcher on Aug 10th, 2020
    Plantmon visited Maisy Smith on Apr 7th, 2021
    Squirtle visited Stephanie Mendez on Sep 29th, 2019
    Angemon visited Jack Harkness on Oct 3rd, 2020
    Angemon visited Jack Harkness on Nov 4th, 2020
    Boarmon visited Maisy Smith on Jan 24th, 2019
    Boarmon visited Maisy Smith on May 15th, 2019
    Boarmon visited Maisy Smith on Feb 27th, 2020
    Boarmon visited Maisy Smith on Aug 3rd, 2020
    Blossom visited Stephanie Mendez on May 24th, 2020
    Blossom visited William Tatcher on Jan 11th, 2021
*/

INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (3, 1, '2020-07-22');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (4, 2, '2021-02-02');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 3, '2020-01-05');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 3, '2020-03-08');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 3, '2020-05-14');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (3, 4, '2021-05-04');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (4, 5, '2021-02-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 6, '2019-12-21');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (1, 6, '2020-08-10');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 6, '2021-04-07');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (3, 7, '2019-09-29');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (4, 8, '2020-10-03');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (4, 8, '2020-11-04');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 9, '2019-01-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 9, '2019-05-15');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 9, '2020-02-27');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (2, 9, '2020-08-03');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (3, 10, '2020-05-24');
INSERT INTO visits (vet_id, animal_id, date_of_visit) VALUES (1, 10, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)

INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)

INSERT INTO owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';