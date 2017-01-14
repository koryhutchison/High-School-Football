/*****************************************************************
  File:        HighschoolFootball.sql
  Description: Used for creating the objects and loading data
               into the HighschoolFootball schema for MSSQL
  Created:     November 21, 2016 
  Modified:    November 21, 2016 
  Version:     1.0
  Name: Kory Hutchison
******************************************************************/

CREATE DATABASE HSFootball;
GO

USE HSFootball;
GO


DROP TABLE City;
DROP TABLE Schools;
DROP TABLE Games;
DROP TABLE Players;

---- Creating Table 'City'
CREATE TABLE [City] (
  [CityID] int,
  [CityName] varchar(30),
  [StateName] varchar(2),
  PRIMARY KEY ([CityID])
);

---- Creating Table 'Schools'
CREATE TABLE [Schools] (
  [SchoolID] int IDENTITY(1,1),
  [SchoolName] varchar(30),
  [SchoolTeamName] varchar(30),
  [SchoolCoach] varchar(30),
  [SchoolWins] int,
  [SchoolLosses] int,
  [CityID] int,
  PRIMARY KEY ([SchoolID])
);

CREATE INDEX [FK] ON  [Schools] ([CityID]);

---- Creating Table 'Games'
CREATE TABLE [Games] (
  [GameID] int IDENTITY(1,1),
  [GameDate] date,
  [GameHomeSchoolID] int,
  [GameHomeScore] int,
  [GameAwaySchoolID] int,
  [GameAwayScore] int,
  PRIMARY KEY ([GameID])
);

CREATE INDEX [FK] ON  [Games] ([GameHomeSchoolID], [GameAwaySchoolID]);

---- Creating Table 'Players'
CREATE TABLE [Players] (
  [PlayerID] int IDENTITY(1,1),
  [PlayerName] varchar(30),
  [PlayerNumber] int,
  [SchoolID] int,
  PRIMARY KEY ([PlayerID])
);

CREATE INDEX [FK] ON  [Players] ([SchoolID]);

GO

-- load up the City table
INSERT INTO City VALUES (1, 'North Ogden', 'UT');
INSERT INTO City VALUES (2, 'Layton', 'UT');
INSERT INTO City VALUES (3, 'Kaysville', 'UT');

-- load up the Schools table
INSERT INTO Schools VALUES ('Weber', 'Warriors', 'Corbridge', 3, 6, 1);
INSERT INTO Schools VALUES ('Northridge', 'Knights', 'Thompson', 9, 3, 2);
INSERT INTO Schools VALUES ('Davis', 'Darts', 'Bishop', 8, 2, 3);

-- load up the Games table
INSERT INTO Games VALUES ('2011-08-20', 1, 3, null, 7);
INSERT INTO Games VALUES ('2011-08-27', 1, 0, null, 31);
INSERT INTO Games VALUES ('2011-08-20', 2, 21, null, 14);
INSERT INTO Games VALUES ('2011-09-03', 2, 13, null, 54);
INSERT INTO Games VALUES ('2011-09-03', 3, 27, null, 20);
INSERT INTO Games VALUES ('2011-09-17', 3, 6, null, 14);

-- load up the Players table
INSERT INTO Players VALUES ('Locke', 42, 1);
INSERT INTO Players VALUES ('Reyes', 18, 1);
INSERT INTO Players VALUES ('Austin', 6, 2);
INSERT INTO Players VALUES ('Shepherd', 42, 3);

-- add constraints

ALTER TABLE Schools
	ADD CONSTRAINT FK_CityID FOREIGN KEY(cityID) REFERENCES City(CityID);

ALTER TABLE Players
	ADD CONSTRAINT FK_SchoolID FOREIGN KEY(schoolID) REFERENCES Schools(SchoolID);
    
ALTER TABLE Games
	ADD CONSTRAINT FK_GameHomeSchoolID FOREIGN KEY(gamehomeschoolID) REFERENCES Schools(SchoolID);
    
ALTER TABLE Games
	ADD CONSTRAINT FK_GameAwaySchoolID FOREIGN KEY(gameawayschoolID) REFERENCES Schools(SchoolID);