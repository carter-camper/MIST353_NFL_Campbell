-- Create a database for NFL App




use MIST353_NFL_Campbell;

create table ConferenceDivision(
    CDID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL,
        CONSTRAINT CK_ConferenceNames Check (Conference IN ('AFC','NFC')),
    Division NVARCHAR(50) NOT NULL 
        CONSTRAINT CK_DivisionNames Check (Division in ('North','East','South','West'))
)



create table Team (
    TeamID INT identity(1,1)
        CONSTRAINT PK_Team PRIMARY KEY,
    Tname NVARCHAR(50) NOT NULL,
    TcityState NVARCHAR(50) NOT NULL,
    Tcolors NVARCHAR(50) NOT NULL,
    Tlogo NVARCHAR(50) NOT NULL,
    CDID INT NOT NULL
        constraint FK_Team_ConferenceDivision foreign key REFERENCES ConferenceDivision
);




-- Create tables for first iteration
