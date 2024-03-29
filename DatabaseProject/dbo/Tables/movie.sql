CREATE TABLE [dbo].[movie] (
    [id]                INT             NOT NULL,
    [adult]             NVARCHAR (300)  NOT NULL,
    [budget]            INT             NOT NULL,
    [homepage]          NVARCHAR (300)  NULL,
    [original_language] NVARCHAR (300)  NOT NULL,
    [original_title]    NVARCHAR (300)  NOT NULL,
    [title]             NVARCHAR (300)  NOT NULL,
    [tagline]           NVARCHAR (300)  NULL,
    [overview]          NVARCHAR (1000) NULL,
    [popularity]        FLOAT (53)      NOT NULL,
    [release_date]      DATE            NULL,
    [revenue]           INT             NOT NULL,
    [runtime]           FLOAT (53)      NULL
);
GO

ALTER TABLE [dbo].[movie]
    ADD CONSTRAINT [PK_movie_id] PRIMARY KEY CLUSTERED ([id] ASC);
GO

