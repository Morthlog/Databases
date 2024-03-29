CREATE TABLE [dbo].[productioncompany] (
    [id]   INT            NOT NULL,
    [name] NVARCHAR (100) NOT NULL
);
GO

ALTER TABLE [dbo].[productioncompany]
    ADD CONSTRAINT [PK_productionCompany_id] PRIMARY KEY CLUSTERED ([id] ASC);
GO

