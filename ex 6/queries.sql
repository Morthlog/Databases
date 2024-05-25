/*1. Αριθμός ταινιών ανά έτος (year, movies_per_year) για ταινίες με budget ταινίας
μεγαλύτερο από 1,000,000.*/

SELECT Year(release_date) as year , Count(*) as 'movies_per_year'
FROM movie
WHERE budget > 1000000
GROUP BY Year(release_date)
ORDER BY year;

/*2. Αριθμός ταινιών ανά είδος (genre, movies_per_genre) για ταινίες που έχουν
budget μεγαλύτερο από 1,000,000 ή διάρκεια μεγαλύτερη από 2 ώρες.*/

SELECT g.name as genre, Count(*) as 'movies_per_genre'
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
WHERE budget > 1000000 OR m.runtime > 120
GROUP BY g.name
ORDER BY genre;

/*3. Αριθμός ταινιών ανά είδος και ανά έτος (genre, year, movies_per_gy) .*/

SELECT g.name as genre, YEAR(m.release_date) as year, COUNT(*) as movies_per_gy
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
GROUP BY YEAR(m.release_date), g.name
ORDER BY genre, year;

/*4. Για τον αγαπημένο σας ηθοποιό, το σύνολο των εσόδων (revenue) για τις ταινίες στις
οποίες έχει συμμετάσχει ανά έτος (year, revenues_per_year).*/

SELECT YEAR(m.release_date) as year, 
    CASE WHEN SUM(m.revenue) = '0' THEN '0'
        ELSE FORMAT(SUM(m.revenue), '#,###') END as revenues_per_year
FROM movie m
INNER JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Leonardo DiCaprio'
GROUP BY YEAR(m.release_date)
ORDER BY year;

/*5. Το υψηλότερο budget ταινίας ανά έτος (year, max_budget), όταν το budget αυτό
δεν είναι μηδενικό.*/
SELECT YEAR(release_date) as year, FORMAT(MAX(budget), '#,###') as max_budget
FROM movie
WHERE budget > 0
GROUP BY YEAR(release_date)
ORDER BY year;



/*6. Τις συλλογές του πίνακα Collection που αναφέρονται σε τριλογίες, δηλαδή η
συλλογή έχει ακριβώς 3 ταινίες (trilogy_name).*/
SELECT name as trilogy_name
FROM collection
WHERE id in(
	SELECT collection_id
	FROM belongsTocollection
	GROUP BY collection_id
	HAVING COUNT(movie_id)=3
)
ORDER BY name;

/*7. Για κάθε χρήστη του πίνακα Ratings, να επιστραφούν η μέση βαθμολογία του χρήστη
και ο αριθμός των βαθμολογιών του (avg_rating, rating_count).*/
SELECT ROUND(AVG(rating),2) as avg_rating, COUNT(rating) as rating_count
FROM ratings
GROUP BY user_id
ORDER BY avg_rating, rating_count;


/*8. Οι 10 ταινίες με το υψηλότερο budget (movie_title, budget). Σε περίπτωση που
έχουμε ισοβαθμία μεταξύ δύο ή περισσοτέρων ταινιών για την θέση 10 και μετά, να
επιστραφεί μία από τις δύο.
(hint: Να χρησιμοποιηθεί ο τελεστής ORDER BY σε συνδυασμό με τον τελεστή TOP της
Microsoft SQL)*/

SELECT TOP 10 m.title as movie_title, FORMAT(m.budget, '#,###') as budget
FROM movie m
ORDER BY m.budget DESC;

/*9. Χρησιμοποιώντας το ερώτημα 5, βρείτε με εμφώλευση την ταινία (ταινίες) με το
μεγαλύτερο budget ανά χρονιά (year, movies_with_max_budget), έχοντας
ταξινόμηση ως προς το έτος και το όνομα της ταινίας.*/
SELECT year, title as movies_with_max_budget
FROM movie m JOIN 
(
    SELECT YEAR(release_date) as year, MAX(budget) as max_budget
    FROM movie
    WHERE budget > 0
    GROUP BY YEAR(release_date)
) as mx ON mx.year=YEAR(m.release_date)
WHERE mx.max_budget=m.budget
ORDER BY year, title;


/*10. Χρησιμοποιώντας εμφώλευση, επιστρέψτε τους σκηνοθέτες (name, surname) που
έχουν σκηνοθετήσει τόσο ταινίες τρόμου, όσο και κωμωδίες, αλλά κανένα άλλο είδος
ταινίας.
(hint: Μπορούν να χρησιμοποιηθούν οι τελεστές EXISTS, NOT EXISTS μαζί με
συνθήκη ζεύξης μεταξύ του εξωτερικού και του εσωτερικού ερωτήματος)*/

SELECT SUBSTRING(dir.name, 0, CHARINDEX(' ', dir.name)) as name, SUBSTRING(dir.name, CHARINDEX(' ', dir.name), LEN(dir.name)) as surname
FROM (
    SELECT DISTINCT cr.person_id, cr.name
    FROM movie_crew cr
    WHERE cr.job = 'Director'
) dir
WHERE EXISTS (
    SELECT h.movie_id
    FROM hasGenre h
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Comedy' AND h.movie_id IN
    (
        SELECT cr2.movie_id
        FROM movie_crew cr2
        WHERE cr2.person_id = dir.person_id AND cr2.job = 'Director'
    )
) AND EXISTS (
    SELECT h.movie_id
    FROM hasGenre h
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Horror' AND h.movie_id IN
    (
        SELECT cr2.movie_id
        FROM movie_crew cr2
        WHERE cr2.person_id = dir.person_id AND cr2.job = 'Director'
    )
) AND NOT EXISTS (
    SELECT h.movie_id
    FROM hasGenre h
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name NOT IN ('Comedy', 'Horror') AND h.movie_id IN
    (
        SELECT cr2.movie_id
        FROM movie_crew cr2
        WHERE cr2.person_id = dir.person_id AND cr2.job = 'Director'
    )
);

/*11. Να απαντηθεί το προηγούμενο ερώτημα χρησιμοποιώντας τελεστές για σύνολα UNION,
INTERSECT, EXCEPT.*/
WITH filtered AS (
    SELECT cr.name
    FROM hasGenre h
    JOIN movie_crew cr ON cr.movie_id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Comedy' AND cr.job = 'DIRECTOR'

    INTERSECT

    SELECT cr.name
    FROM hasGenre h
    JOIN movie_crew cr ON cr.movie_id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Horror' AND cr.job = 'DIRECTOR'

    EXCEPT

    SELECT cr.name
    FROM hasGenre h
    JOIN movie_crew cr ON cr.movie_id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name NOT IN ('Comedy', 'Horror') AND cr.job = 'DIRECTOR'
)

SELECT SUBSTRING(f.name, 0, CHARINDEX(' ', f.name)) as name, SUBSTRING(f.name, CHARINDEX(' ', f.name), LEN(f.name)) as surname
FROM filtered f;


/*Θεωρείστε ότι ένα ζεύγος ταινιών είναι δημοφιλές όταν υπάρχουν πάνω από 10 χρήστες που
έχουν βαθμολογήσει και τις 2 ταινίες με άνω του 4 βαθμολογία.
12. Προσδιορίστε το ερώτημα το οποίο θα χρησιμοποιηθεί για να φτιάξουμε ένα view (όψη)
με το όνομα Popular_Movie_Pairs που περιέχει τα ids από τα δημοφιλή ζεύγη
ταινιών (id1,id2).*/

CREATE VIEW Popular_Movie_Pairs AS
WITH popular_movies AS (
    SELECT movie_id,COUNT(user_id) as total_users
    FROM ratings
    WHERE rating>4
    GROUP BY movie_id
    HAVING COUNT(user_id)>10)
SELECT p1.movie_id as id1, p2.movie_id as id2
FROM popular_movies p1 
JOIN popular_movies p2 ON p1.movie_id<p2.movie_id;