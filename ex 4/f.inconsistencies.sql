/*=========Αντικατάσταση των διπλότυπων με το μέγιστο genre (υποθέτουμε οτι έχει δυο, το σωστό και το άγνωστο)===========*/
UPDATE movie_crew
SET gender = (
    SELECT MAX(gender)
    FROM (
        SELECT person_id, gender
        FROM movie_crew 
        UNION
        SELECT person_id, gender
        FROM movie_cast
    ) AS combined_data
    WHERE combined_data.person_id = movie_crew.person_id
)
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(DISTINCT gender) > 1
);


UPDATE movie_cast
SET gender = (
    SELECT MAX(gender)
    FROM (
        SELECT person_id, gender
        FROM movie_crew 
        UNION
        SELECT person_id, gender
        FROM movie_cast
    ) AS combined_data
    WHERE combined_data.person_id = movie_cast.person_id
)
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(DISTINCT gender) > 1
);

/*=========Αντικατάσταση των διπλότυπων με το πρώτο όνομα===========*/

UPDATE movie_cast
SET name = (
    SELECT TOP(1) name
    FROM (
        SELECT person_id, name
        FROM movie_crew 
        UNION 
        SELECT person_id, name
        FROM movie_cast
    ) AS combined_data
    WHERE combined_data.person_id = movie_cast.person_id
)
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(DISTINCT name) > 1
);

UPDATE movie_crew
SET name = (
    SELECT TOP(1) name
    FROM (
        SELECT person_id, name
        FROM movie_crew 
        UNION
        SELECT person_id, name
        FROM movie_cast
    ) AS combined_data
    WHERE combined_data.person_id = movie_crew.person_id
)
WHERE person_id IN (
    SELECT person_id
    FROM Person
    GROUP BY person_id
    HAVING COUNT(DISTINCT name) > 1
);



