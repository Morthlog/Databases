CREATE TABLE [dbo].[hasProductioncompany] (
    [movie_id] INT NOT NULL,
    [pc_id]    INT NOT NULL,
    CONSTRAINT [FK_hasPC_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id]),
    CONSTRAINT [FK_hasPC_pc_id] FOREIGN KEY ([pc_id]) REFERENCES [dbo].[productioncompany] ([id])
);
GO


