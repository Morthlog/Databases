USE master;
GO
ALTER DATABASE ExercisesDatabase
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

--εδω μπαινει το script που δημιουργειται οταν πατησουμε δεξι κλικ στο ExercisedDatabase->restore->script
USE [master]
BACKUP LOG [ExercisesDatabase] TO  DISK = N'/var/opt/mssql/data/ExercisesDatabase_LogBackup_2024-04-20_11-33-38.bak' WITH NOFORMAT, NOINIT,  NAME = N'ExercisesDatabase_LogBackup_2024-04-20_11-33-38', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [ExercisesDatabase] FROM  DISK = N'/var/opt/mssql/data/ExercisesDatabase-2024420-14-31-56.bak' WITH  FILE = 1,  MOVE N'ExercisesDatabase_Data' TO N'/var/opt/mssql/data/ExercisesDatabase.mdf',  MOVE N'ExercisesDatabase_Log' TO N'/var/opt/mssql/data/ExercisesDatabase.ldf',  NOUNLOAD,  STATS = 5
--εδω μπαινει το script που δημιουργειται οταν πατησουμε δεξι κλικ στο ExercisedDatabase->restore->script

USE master;
GO
ALTER DATABASE ExercisesDatabase
SET MULTI_USER;
GO