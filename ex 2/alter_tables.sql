ALTER TABLE movie
    ADD CONSTRAINT PK_movie_id
PRIMARY KEY (id); 

ALTER TABLE collection
    ADD CONSTRAINT PK_collection_id
PRIMARY KEY (id);

ALTER TABLE genre
    ADD CONSTRAINT PK_genre_id
PRIMARY KEY (id);

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FR_belong_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FR_belong_collection_id FOREIGN
KEY (collection_id)
    REFERENCES collection(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FR_hasGenre_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FR_hasGenre_genre_id FOREIGN
KEY (genre_id)
    REFERENCES genre(id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FR_hasPC_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FR_hasPC_pc_id FOREIGN
KEY (pc_id)
    REFERENCES productioncompany(id);
