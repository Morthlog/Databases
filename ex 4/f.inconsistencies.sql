UPDATE movie_cast
SET gender=2  where person_id in (
SELECT person_id
FROM person
GROUP BY person_id
HAVING COUNT(name) > 1 OR COUNT(gender) > 1
);

UPDATE movie_crew
SET gender=2  where person_id in (
SELECT person_id
FROM person
GROUP BY person_id
HAVING COUNT(name) > 1 OR COUNT(gender) > 1
);

UPDATE movie_crew
SET name='Ka-Fai Cheung'  where person_id in (
SELECT person_id
FROM person
GROUP BY person_id
HAVING COUNT(name) > 1 OR COUNT(gender) > 1
);