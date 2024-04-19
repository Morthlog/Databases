CREATE VIEW Actor AS
SELECT DISTINCT person_id, gender, name
FROM movie_cast;

Go -- used to run statements in succession

CREATE VIEW CrewMember AS
SELECT DISTINCT person_id, gender, name
FROM movie_crew;

Go -- used to run statements in succession

CREATE VIEW Person AS
(
    SELECT * FROM Actor 
    UNION 
    SELECT * FROM CrewMember
);