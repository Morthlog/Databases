-- A

ALTER TABLE movie
ADD AVG_Rating FLOAT (53);

-- B

with averages AS
(
    SELECT avg(r.rating) as average, m.id
    FROM movie m
    INNER JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.id
)

UPDATE movie
SET AVG_Rating = 
(
    SELECT average
    FROM averages
    WHERE averages.id = movie.id
);

-- C
/*
CREATE TRIGGER re_calc_avg_rating ON ratings
AFTER INSERT
AS BEGIN
    UPDATE movie
    SET AVG_Rating =
    (
        SELECT avg(r.rating)
        FROM ratings r
        WHERE r.movie_id = inserted.movie_id
    )
    FROM movie m
    INNER JOIN inserted ON m.id = inserted.movie_id;
END
*/

-- D

-- Need previous parts

-- E

/*
Μπορούμε να προσθέσουμε στον πίνακα movie ένα ακόμα column όπου θα περιέχει το count των ratings του (με όνομα CountR), το οποίο για την Ariel, με id = 2, θα ήταν 107.
Όποτε θα προσθέταμε ένα νέο rating, θα ενημερώναμε το AGV_Rating με τον παρακάτω τύπο:
(CountR * AVG_Rating + inserted.rating) / (CountR + 1)
Με αυτόν τον τύπο, μπορούμε να ξαναβρούμε τον μέσο όρο χωρίς να χρειαστεί να απευθυνθούμε στις προηγούμενες εγγραφές του Rating.
Στο τέλος αυξάνεται και το CountR κατά 1, για να μπορεί να χρησιμοποιηθεί στην επόμενη εισαγωγή.
Με την χρήση του τροποποιημένου αυτού τύπου προσθέτουμε μόνο 1 παραπάνω column για αποθήκευση των απαιτούμενων δεδομένων, με μοναδικό έξτρα κόστος το κόστος του πολλαπλασιασμού.
*/
