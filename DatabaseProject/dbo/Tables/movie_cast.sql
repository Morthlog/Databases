CREATE TABLE [dbo].[movie_cast] (
    [cid]       INT            NOT NULL,
    [movie_id]  INT            NOT NULL,
    [character] NVARCHAR (400) NULL,
    [gender]    TINYINT        NOT NULL,
    [person_id] INT            NOT NULL,
    [name]      NVARCHAR (50)  NOT NULL
);
GO

ALTER TABLE [dbo].[movie_cast]
    ADD CONSTRAINT [FK_moviecast_movie_id] FOREIGN KEY ([movie_id]) REFERENCES [dbo].[movie] ([id]);
GO

ALTER TABLE [dbo].[movie_cast]
    ADD CONSTRAINT [PK_movieCast_cid] PRIMARY KEY CLUSTERED ([cid] ASC);
GO

