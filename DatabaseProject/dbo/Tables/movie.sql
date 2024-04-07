CREATE TABLE [dbo].[movie] (
    [id]                INT             NOT NULL,
    [adult]             NVARCHAR (500)  NOT NULL,
    [budget]            INT             NOT NULL,
    [homepage]          NVARCHAR (500)  NULL,
    [original_language] NVARCHAR (500)  NOT NULL,
    [original_title]    NVARCHAR (500)  NOT NULL,
    [title]             NVARCHAR (500)  NOT NULL,
    [tagline]           NVARCHAR (500)  NULL,
    [overview]          NVARCHAR (1000) NULL,
    [popularity]        FLOAT (53)      NOT NULL,
    [release_date]      DATE            NULL,
    [revenue]           INT             NOT NULL,
    [runtime]           SMALLINT        NULL,
    CONSTRAINT [PK_movie_id] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO

