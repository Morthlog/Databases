CREATE TABLE [dbo].[belongsTocollection] (
    [movie_id]      INT NOT NULL,
    [collection_id] INT NOT NULL,
    CONSTRAINT [FK_belong_collection_id] FOREIGN KEY ([collection_id]) REFERENCES [dbo].[collection] ([id]),
    CONSTRAINT [FK_belong_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);
GO


