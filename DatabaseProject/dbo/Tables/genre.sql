CREATE TABLE [dbo].[genre] (
    [id]   INT           NOT NULL,
    [name] VARCHAR (300) NOT NULL
);
GO

ALTER TABLE [dbo].[genre]
    ADD CONSTRAINT [PK_genre_id] PRIMARY KEY CLUSTERED ([id] ASC);
GO

