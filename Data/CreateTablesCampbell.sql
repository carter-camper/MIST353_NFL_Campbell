-- Create a database for NFL App


--use MIST353_NFL_Campbell;

--use [mist353-nfl-campbell];

--use [mist353-nfl-campbell];

--use MIST353_NFL_Campbell;

use master;




if (object_ID('Team') is not null)
    drop table Team;
if (object_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;


--Create ConferenceDivision 

create table ConferenceDivision(
    CDID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL,
        CONSTRAINT CK_ConferenceNames Check (Conference IN ('AFC','NFC')),
    Division NVARCHAR(50) NOT NULL 
        CONSTRAINT CK_DivisionNames Check (Division in ('North','East','South','West'))   
);

alter table ConferenceDivision
    add CONSTRAINT UQ_ConferenceDivision UNIQUE (Conference, Division)
/*
alter table ConferenceDivision
    NOCHECK CONSTRAINT CK_ConferenceNames;

alter table ConferenceDivision
    CHECK CONSTRAINT CK_ConferenceNames;    
*/


--Create Team table

create table Team (
    TeamID INT identity(1,1)
        CONSTRAINT PK_Team PRIMARY KEY,
    Tname NVARCHAR(50) NOT NULL,
    TcityState NVARCHAR(50) NOT NULL,
    Tcolors NVARCHAR(100) NOT NULL,
    Tlogo NVARCHAR(50) NOT NULL,
    CDID INT NOT NULL
        constraint FK_Team_ConferenceDivision foreign key REFERENCES ConferenceDivision
);





