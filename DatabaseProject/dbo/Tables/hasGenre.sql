CREATE TABLE [dbo].[hasGenre] (
    [movie_id] INT NOT NULL,
    [genre_id] INT NOT NULL,
    CONSTRAINT [FK_hasGenre_genre_id] FOREIGN KEY ([genre_id]) REFERENCES [dbo].[genre] ([id]),
    CONSTRAINT [FK_hasGenre_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);


GO

