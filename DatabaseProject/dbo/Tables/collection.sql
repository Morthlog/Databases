CREATE TABLE [dbo].[collection] (
    [id]   INT           NOT NULL,
    [name] VARCHAR (300) NOT NULL
);
GO

ALTER TABLE [dbo].[collection]
    ADD CONSTRAINT [PK_collection_id] PRIMARY KEY CLUSTERED ([id] ASC);
GO

