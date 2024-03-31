CREATE TABLE [dbo].[movie_crew] (
    [cid]        INT            NOT NULL,
    [movie_id]   INT            NOT NULL,
    [department] NVARCHAR (100) NOT NULL,
    [gender]     INT            NOT NULL,
    [person_id]  INT            NOT NULL,
    [job]        NVARCHAR (100) NOT NULL,
    [name]       NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_movieCrew_cid] PRIMARY KEY CLUSTERED ([cid] ASC),
    CONSTRAINT [FK_moviecrew_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id])
);
GO

