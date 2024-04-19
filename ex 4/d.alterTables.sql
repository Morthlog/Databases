ALTER TABLE hasGenre
    ADD CONSTRAINT PK_hasGenre_movieId_genreId
PRIMARY KEY (movie_id,genre_id); 

ALTER TABLE hasKeyword
    ADD CONSTRAINT PK_hasKeyword_movieId_keyId
PRIMARY KEY (movie_id,key_id); 

ALTER TABLE belongsTocollection
    ADD CONSTRAINT PK_belongsTocollection_movieId
PRIMARY KEY (movie_id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT PK_hasProductioncompany_movieId_pcId
PRIMARY KEY (movie_id, pc_id);

ALTER TABLE ratings
    ADD CONSTRAINT PK_ratings_userId_movieId
PRIMARY KEY (user_id,movie_id); 
