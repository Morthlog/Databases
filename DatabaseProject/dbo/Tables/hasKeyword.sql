CREATE TABLE [dbo].[hasKeyword] (
    [movie_id] INT NOT NULL,
    [key_id]   INT NOT NULL,
    CONSTRAINT [FK_hasKeyword_keyword_id] FOREIGN KEY ([key_id]) REFERENCES [dbo].[keyword] ([id]),
    CONSTRAINT [FK_hasKeyword_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);


GO

