ALTER TABLE movie
    ADD CONSTRAINT PK_movie_id
PRIMARY KEY (id); 

ALTER TABLE collection
    ADD CONSTRAINT PK_collection_id
PRIMARY KEY (id);

ALTER TABLE genre
    ADD CONSTRAINT PK_genre_id
PRIMARY KEY (id);

ALTER TABLE productioncompany
    ADD CONSTRAINT PK_productionCompany_id
PRIMARY KEY (id);

ALTER TABLE movie_cast
    ADD CONSTRAINT PK_movieCast_cid
PRIMARY KEY (cid);

ALTER TABLE movie_crew
    ADD CONSTRAINT PK_movieCrew_cid
PRIMARY KEY (cid);

ALTER TABLE keyword
    ADD CONSTRAINT PK_keyword_id
PRIMARY KEY (id);

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FK_belong_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FK_belong_collection_id FOREIGN
KEY (collection_id)
    REFERENCES collection(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_hasGenre_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_hasGenre_genre_id FOREIGN
KEY (genre_id)
    REFERENCES genre(id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FK_hasPC_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FK_hasPC_pc_id FOREIGN
KEY (pc_id)
    REFERENCES productioncompany(id);

ALTER TABLE ratings
    ADD CONSTRAINT FK_ratings_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE movie_cast
    ADD CONSTRAINT FK_moviecast_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE movie_crew
    ADD CONSTRAINT FK_moviecrew_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE hasKeyword
    ADD CONSTRAINT FK_hasKeyword_keyword_id FOREIGN
KEY (key_id)
    REFERENCES keyword(id);

ALTER TABLE hasKeyword
    ADD CONSTRAINT FK_hasKeyword_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id);
