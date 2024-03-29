CREATE TABLE [dbo].[keyword] (
    [id]   INT           NOT NULL,
    [name] NVARCHAR (50) NOT NULL
);
GO

ALTER TABLE [dbo].[keyword]
    ADD CONSTRAINT [PK_keyword_id] PRIMARY KEY CLUSTERED ([id] ASC);
GO

