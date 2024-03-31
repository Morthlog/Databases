CREATE TABLE [dbo].[movie_cast] (
    [cid]       INT             NOT NULL,
    [movie_id]  INT             NOT NULL,
    [character] NVARCHAR (1000) NULL,
    [gender]    INT             NOT NULL,
    [person_id] INT             NOT NULL,
    [name]      NVARCHAR (1000) NOT NULL,
    CONSTRAINT [PK_movieCast_cid] PRIMARY KEY CLUSTERED ([cid] ASC),
    CONSTRAINT [FK_moviecast_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);
GO

