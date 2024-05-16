/*1. Αριθμός ταινιών ανά έτος (year, movies_per_year) για ταινίες με budget ταινίας
μεγαλύτερο από 1,000,000.*/

SELECT Year(release_date) as year , Count(*) as 'movies_per_year'
FROM movie
WHERE budget > 1000000
GROUP BY Year(release_date)
Order By Year(release_date);

/*2. Αριθμός ταινιών ανά είδος (genre, movies_per_genre) για ταινίες που έχουν
budget μεγαλύτερο από 1,000,000 ή διάρκεια μεγαλύτερη από 2 ώρες.*/

SELECT g.name as genre, Count(*) as 'movies_per_genre'
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
WHERE budget > 1000000 OR m.runtime > 120
GROUP BY g.name;

/*3. Αριθμός ταινιών ανά είδος και ανά έτος (genre, year, movies_per_gy) .*/

SELECT g.name as genre, YEAR(m.release_date) as year, COUNT(*) as movies_per_gy
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
GROUP BY YEAR(m.release_date), g.name;

/*4. Για τον αγαπημένο σας ηθοποιό, το σύνολο των εσόδων (revenue) για τις ταινίες στις
οποίες έχει συμμετάσχει ανά έτος (year, revenues_per_year).*/

SELECT YEAR(m.release_date) as year, SUM(m.revenue) as revenues_per_year
FROM movie m
INNER JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Leonardo DiCaprio'
GROUP BY YEAR(m.release_date);

/*5. Το υψηλότερο budget ταινίας ανά έτος (year, max_budget), όταν το budget αυτό
δεν είναι μηδενικό.*/



/*6. Τις συλλογές του πίνακα Collection που αναφέρονται σε τριλογίες, δηλαδή η
συλλογή έχει ακριβώς 3 ταινίες (trilogy_name).*/



/*7. Για κάθε χρήστη του πίνακα Ratings, να επιστραφούν η μέση βαθμολογία του χρήστη
και ο αριθμός των βαθμολογιών του (avg_rating, rating_count).*/



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



/*10. Χρησιμοποιώντας εμφώλευση, επιστρέψτε τους σκηνοθέτες (name, surname) που
έχουν σκηνοθετήσει τόσο ταινίες τρόμου, όσο και κωμωδίες, αλλά κανένα άλλο είδος
ταινίας.
(hint: Μπορούν να χρησιμοποιηθούν οι τελεστές EXISTS, NOT EXISTS μαζί με
συνθήκη ζεύξης μεταξύ του εξωτερικού και του εσωτερικού ερωτήματος)*/

SELECT SUBSTRING(cr.name, 0, CHARINDEX(' ', cr.name)) as name, SUBSTRING(cr.name, CHARINDEX(' ', cr.name), LEN(cr.name)) as surname
FROM movie_crew cr
WHERE cr.job = 'Director' AND EXISTS
(
    SELECT m.id
    FROM movie m
    INNER JOIN hasGenre h ON m.id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Comedy' AND cr.movie_id = m.id
) AND EXISTS
(
    SELECT m.id
    FROM movie m
    INNER JOIN hasGenre h ON m.id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name = 'Horror' AND cr.movie_id = m.id
) AND NOT EXISTS
(
    SELECT m.id
    FROM movie m
    INNER JOIN hasGenre h ON m.id = h.movie_id
    INNER JOIN genre g ON g.id = h.genre_id
    WHERE g.name NOT IN ('Comedy', 'Horror') AND cr.movie_id = m.id
)

/*11. Να απαντηθεί το προηγούμενο ερώτημα χρησιμοποιώντας τελεστές για σύνολα UNION,
INTERSECT, EXCEPT.*/



/*Θεωρείστε ότι ένα ζεύγος ταινιών είναι δημοφιλές όταν υπάρχουν πάνω από 10 χρήστες που
έχουν βαθμολογήσει και τις 2 ταινίες με άνω του 4 βαθμολογία.
12. Προσδιορίστε το ερώτημα το οποίο θα χρησιμοποιηθεί για να φτιάξουμε ένα view (όψη)
με το όνομα Popular_Movie_Pairs που περιέχει τα ids από τα δημοφιλή ζεύγη
ταινιών (id1,id2).*/

