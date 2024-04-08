/*Εμφάνισε όλους τους τίτλους ταινιών φαντασίας και το μέσο όρο τους, με μέση βαθμολογία πάνω  από 4
--Output: 14 rows
*/
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN hasgenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE g.name = 'Fantasy'
GROUP BY m.title
HAVING AVG(r.rating) > 4;

/* Εμφάνισε όλες τις ταινίες όπου είναι ηθοποιός o Arnold Schwarzenegger
Output: 32 rows
*/
SELECT m.title
FROM movie m
JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Arnold Schwarzenegger'


/* Εμφάνισε όλους τους  τίτλους ταινιών περιπέτειας , το budget και την ημερομηνία κυκλοφορίας, με budget > 100.000.000 μετά το 2000.
Output: 29 rows
*/
SELECT m.title,m.budget,m.release_date
FROM movie m
JOIN hasgenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE g.name = 'Adventure' AND m.budget>100000000 AND YEAR(m.release_date)> 2000


/* Εμφάνισε όλους τους τίτλους ταινιών,το revenue και το rating τους, με revenue >900.000.000 σε φθίνουσα σειρά.
Output: 7 rows
*/
SELECT m.title,m.revenue, AVG(r.rating) AS avg_rating
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.revenue > 900000000
GROUP BY m.title, m.revenue
ORDER BY revenue DESC;

/* Εμφάνισε τις τοπ 10 πιο δημοφιλεις ταινίες με λέξεις κλειδιά που να περιέχουν "bomb" ή "atomic".
Output: 10 rows*/
SELECT DISTINCT TOP(10)  m.title, m.popularity
FROM movie m
JOIN hasKeyword hk ON m.id = hk.movie_id
JOIN keyword k ON hk.key_id = k.id
WHERE k.name LIKE '%bomb%'OR k.name LIKE '%atomic%'
ORDER BY m.popularity DESC;

/* Εμφάνισε τα studio των τοπ 10 πιο κερδοφόρων ταινιών
Output: 24 rows*/
Select pc.name, m.title
FROM movie m
JOIN hasProductioncompany hpc ON hpc.movie_id=m.id
JOIN productioncompany pc ON hpc.pc_id=pc.id
where m.id IN (
    SELECT TOP(10) id
    FROM movie
    ORDER BY revenue DESC)
    ORDER BY m.title
	
/*
Εμφάνισε τους 10 καλύτερους σκηνοθέτες με τις καλύτερες σε βαθμολογία ταινίες τους, σε φθίνουσα σειρά και τα ratings τους
Output: 10 rows
NOTE: The same director appears twice in the same row
*/
/*
SELECT TOP (10) STRING_AGG(CAST(c.name as nvarchar(MAX)), ', ')  AS 'Director''s names', avg(r.rating) as 'Average Ratings',
(
    SELECT m.title
    FROM movie m
    WHERE m.id = c.movie_id
) as 'Movie''s name'
FROM movie_crew c
INNER JOIN ratings r
ON r.movie_id = c.movie_id
GROUP BY c.department, c.movie_id
HAVING c.department = 'Directing'
ORDER BY 'Average Ratings' DESC
 */

/*
Εμφάνισε  το σύνολο του crew και cast που εργάστηκε για τη συλλογή "lord of the rings"
Output: 96 rows
 */
/*
WITH movieIDs AS 
(
    SELECT b.movie_id
    FROM collection co
    INNER JOIN belongsTocollection b
    ON b.collection_id = co.id
    WHERE co.name ='The Lord of the Rings Collection'
)

SELECT DISTINCT
    CASE 
        WHEN cr.name IS NOT NULL THEN cr.name
        ELSE ca.name
    END AS name,
    cr.department, ca.character
FROM movie_crew cr
FULL OUTER JOIN movie_cast ca 
ON cr.cid = ca.cid
WHERE cr.movie_id IN (SELECT movie_id FROM movieIDs)
    OR ca.movie_id IN (SELECT movie_id FROM movieIDs)
*/

/*
Εμφάνισε τις ταινίες των εταιρειών "Walt Disney Pictures" και "Universal Pictures" με revenue > 500.000.000
Output: 8 rows 
*/

/*
SELECT m.title, m.revenue, pr.name
FROM movie m
INNER JOIN HasProductioncompany has
ON has.movie_id = m.id
INNER JOIN productioncompany pr
ON pr.id = has.pc_id
WHERE m.id IN 
(
    SELECT has.movie_id
    WHERE pr.name = 'Walt Disney Pictures'
        OR pr.name = 'Universal Pictures'
)
    AND m.revenue > 500000000
    AND (pr.name = 'Walt Disney Pictures' OR pr.name = 'Universal Pictures')
*/
/*
Εμφάνισε όλες τις ταινίες με 4.5 > μέσο όρο > 3 και με τουλάχιστον 100 κριτικές
Output: 59 rows
*/ 
/*
SELECT m.title, avg(r.rating) as 'Average Rating', COUNT(r.rating) as 'Total reviews'
FROM movie m
INNER JOIN ratings r
ON r.movie_id = m.id
GROUP BY m.title
HAVING avg(r.rating) BETWEEN 3 AND 4.5
    AND COUNT(r.rating) > 100
ORDER BY COUNT(r.rating) DESC
*/
/*
Εμφάνισε όλες τις ταινίες οποιαδήποτε Batman collection με τουλάχιστον 7.5% popularity και το μεγαλύτερο revenue της που υπήρξε από ταινία
Output: 5 rows
*/
/*
SELECT m.title, m.popularity, co.name, 
(
    SELECT MAX(m.revenue)
    FROM movie m
    INNER JOIN belongsTocollection b ON b.movie_id = m.id
    INNER JOIN collection co ON b.collection_id = co.id
    WHERE co.name LIKE 'Batman%'
) AS 'Most Revenue'
FROM movie m
INNER JOIN belongsTocollection b
ON b.movie_id = m.id
INNER JOIN collection co
ON b.collection_id = co.id
GROUP BY m.id, m.title, co.name, m.popularity, b.movie_id, m.revenue
HAVING popularity >7.5 AND co.name IN 
(
    SELECT co.name
    WHERE co.name LIKE 'Batman%'
    AND b.movie_id = m.id
) 
*/
/*
Εμφάνισε τις ταινίες με το χαμηλότερο avg rating, εκτός του 0
Output: 8 rows
*/
/*
WITH averageR AS
(
    SELECT avg(r.rating) AS AVG
    FROM movie m
    INNER JOIN ratings r
    ON m.id = r.movie_id
    GROUP BY m.id, m.title, m.popularity
)

SELECT m.title, avg(r.rating) as 'Lowest Rating'
FROM movie m
INNER JOIN ratings r
ON r.movie_id = m.id
GROUP BY m.title, r.movie_id
HAVING avg(r.rating) IN
(
 SELECT MIN(AVG) FROM averageR
)
*/