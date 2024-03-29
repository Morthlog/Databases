CREATE TABLE [dbo].[movie_crew] (
    [cid]        INT           NOT NULL,
    [movie_id]   INT           NOT NULL,
    [department] NVARCHAR (20) NOT NULL,
    [gender]     TINYINT       NOT NULL,
    [person_id]  INT           NOT NULL,
    [job]        NVARCHAR (60) NOT NULL,
    [name]       NVARCHAR (35) NOT NULL
);
GO

ALTER TABLE [dbo].[movie_crew]
    ADD CONSTRAINT [PK_movieCrew_cid] PRIMARY KEY CLUSTERED ([cid] ASC);
GO

ALTER TABLE [dbo].[movie_crew]
    ADD CONSTRAINT [FK_moviecrew_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id]);
GO

