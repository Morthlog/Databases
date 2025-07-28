/* 1. Number of movies per year (year, movies_per_year) for movies with a budget 
greater than 1,000,000. */
SELECT Year(release_date) as year , Count(*) as 'movies_per_year'
FROM movie
WHERE budget > 1000000
GROUP BY Year(release_date)
ORDER BY year;

/* 2. Number of movies per genre (genre, movies_per_genre) for movies with a budget 
greater than 1,000,000 or runtime longer than 2 hours. */
SELECT g.name as genre, Count(*) as 'movies_per_genre'
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
WHERE budget > 1000000 OR m.runtime > 120
GROUP BY g.name
ORDER BY genre;

/* 3. Number of movies per genre and per year (genre, year, movies_per_gy). */
SELECT g.name as genre, YEAR(m.release_date) as year, COUNT(*) as movies_per_gy
FROM movie m
INNER JOIN hasGenre h ON m.id = h.movie_id
INNER JOIN genre g ON g.id = h.genre_id
GROUP BY YEAR(m.release_date), g.name
ORDER BY genre, year;

/* 4. For your favorite actor, total revenue of movies they starred in per year 
(year, revenues_per_year). */
SELECT YEAR(m.release_date) as year, 
    CASE WHEN SUM(m.revenue) = '0' THEN '0'
        ELSE FORMAT(SUM(m.revenue), '#,###') END as revenues_per_year
FROM movie m
INNER JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Leonardo DiCaprio'
GROUP BY YEAR(m.release_date)
ORDER BY year;

/* 5. Highest movie budget per year (year, max_budget), excluding zero-budget movies. */
SELECT YEAR(release_date) as year, FORMAT(MAX(budget), '#,###') as max_budget
FROM movie
WHERE budget > 0
GROUP BY YEAR(release_date)
ORDER BY year;

/* 6. Collections from the Collection table that refer to trilogies, i.e., collections with exactly 3 movies (trilogy_name). */
SELECT name as trilogy_name
FROM collection
WHERE id in(
	SELECT collection_id
	FROM belongsTocollection
	GROUP BY collection_id
	HAVING COUNT(movie_id)=3
)
ORDER BY name;

/* 7. For each user in the Ratings table, return their average rating and the number of ratings 
(avg_rating, rating_count). */
SELECT ROUND(AVG(rating),2) as avg_rating, COUNT(rating) as rating_count
FROM ratings
GROUP BY user_id
ORDER BY avg_rating, rating_count;

/* 8. The 10 movies with the highest budget (movie_title, budget). In case of a tie for the 10th place or beyond,
return one of the tied movies. 
(hint: Use ORDER BY with the TOP operator of Microsoft SQL) */
SELECT TOP 10 m.title as movie_title, FORMAT(m.budget, '#,###') as budget
FROM movie m
ORDER BY m.budget DESC;

/* 9. Using query 5, find with subquery the movie(s) with the highest budget per year 
(year, movies_with_max_budget), ordered by year and movie title. */
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

/* 10. Using subquery, return the directors (name, surname) who have directed both horror and comedy movies,
but no other genres.
(hint: You can use the EXISTS and NOT EXISTS operators along with join conditions between the outer and inner query) */
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

/* 11. Answer the previous question using set operators: UNION, INTERSECT, EXCEPT. */
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

/* Assume that a pair of movies is popular when more than 10 users have rated both movies 
with a rating greater than 4.
12. Define the query to be used to create a view named Popular_Movie_Pairs 
containing the IDs of the popular movie pairs (id1, id2). */
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