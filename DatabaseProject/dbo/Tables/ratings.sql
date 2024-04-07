CREATE TABLE [dbo].[ratings] (
    [user_id]  SMALLINT   NOT NULL,
    [movie_id] INT        NOT NULL,
    [rating]   FLOAT (53) NOT NULL,
    CONSTRAINT [FK_ratings_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);


GO

