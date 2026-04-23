--Insert all ConferenceDivison Data (8 Rows)
--Insert team data for AFC North (4 Rows)

use MIST353_NFL_Campbell;



insert into ConferenceDivision
VALUES
('AFC','North'),
('AFC','East'),
('AFC','South'),
('AFC','West'),
('NFC','North'),
('NFC','East'),
('NFC','South'),
('NFC','West');



insert into Team
values
('Ravens','Baltimore, MD','Purple, Black, Metallic Gold','Logo',1),
('Bengals','Cincinnati, OH','Black, Orange, White','Logo',1),
('Browns','Cleveland, OH','Brown, Orange, White','Logo',1),
('Steelers','Pittsburgh, PA','Black, Gold, White','Logo',1),

('Bills','Buffalo, NY','Royal Blue, Red, White','Logo',2),
('Dolphins','Miami, FL','Aqua, Orange, White','Logo',2),
('Patriots','New England, MA','Navy Blue, Red, Silver','Logo',2),
('Jets','New York, NY','Green, White, Black','Logo',2),

('Texans','Houston, TX','Deep Steel Blue, Battle Red, Liberty White','Logo',3),
('Colts','Indianapolis, IN','Speed Blue, White','Logo',3),
('Jaguars','Jacksonville, FL','Teal, Black, Gold, White','Logo',3),
('Titans','Tennessee, TN','Navy Blue, Titans Blue, Red, White','Logo',3),

('Broncos','Denver, CO','Orange, Navy Blue, White','Logo',4),
('Chiefs','Kansas City, MO','Red, Gold, White','Logo',4),
('Raiders','Las Vegas, NV','Silver, Black','Logo',4),
('Chargers','Los Angeles, CA','Powder Blue, Gold, White','Logo',4),

('Bears','Chicago, IL','Navy Blue, Orange, White','Logo',5),
('Lions','Detroit, MI','Honolulu Blue, Silver, White','Logo',5),
('Packers','Green Bay, WI','Green, Gold, White','Logo',5),
('Vikings','Minnesota, MN','Purple, Gold, White','Logo',5),

('Cowboys','Dallas, TX','Navy Blue, Silver, White','Logo',6),
('Giants','New York, NY','Royal Blue, Red, White','Logo',6),
('Redskins','Washington, DC','Burgundy, Gold, White','Logo',6),
('Eagles','Philadelphia, PA','Midnight Green, Silver, Black, White','Logo',6),

('Cardinals','Arizona, AZ','Cardinal Red, Black, White','Logo',7),
('Rams','Los Angeles, CA','Royal Blue, Yellow, White','Logo',7),
('49ers','San Francisco, CA','Scarlet Red, Gold, White','Logo',7),
('Seahawks','Seattle, WA','College Navy Blue, Action Green, Wolf Grey','Logo',7),

('Falcons','Atlanta, GA','Red, Black, Silver, White','Logo',8),
('Panthers','Carolina, NC','Black, Panther Blue, Silver, White','Logo',8),
('Saints','New Orleans, LA','Old Gold, Black, White','Logo',8),
('Buccaneers','Tampa Bay, FL','Red Pepper Red, Pewter Gray, Orange Red Accent and White Accent Colors ','Logo',8);

-- second phase inserting

-- AppUser insertion

insert into AppUser (Firstname, Lastname, Email, Phone, PasswordHash, UserRole)
VALUES
('Tom', 'Brady', 'tom.brady@example.com', '555-1234', 0x01, N'NFLFan'),
('Aaron', 'Rodgers', 'aaron.rodgers@example.com', '555-9012', 0x01, N'NFLFan'),
('Drew', 'Brees', 'drew.brees@example.com', '555-2222', 0x01, N'NFLFan'),
('Patrick', 'Mahomes', 'patrick.mahomes@example.com', '555-7890', 0x01, N'NFLFan'),
('Bill', 'Belichick', 'bill.belichick@example.com', '555-5678', 0x01, N'NFLAdmin'),
('Sean', 'McVay', 'sean.mcay@example.com', '555-3456', 0x01, N'NFLAdmin'),
('Mike', 'Tomlin', 'mike.tomlin@example.com', '555-1111', 0x01, N'NFLAdmin'),
('Andy', 'Reid', 'andy.reid@example.com', '555-3333', 0x01, N'NFLAdmin');

-- NFLFan insertion

GO
insert into NFLFan (NFLFanID)
VALUES
(1),
(2),
(3),
(4);

-- NFLAdmin insertion

GO
insert into NFLAdmin (NFLAdminID)
VALUES
(5),
(6),
(7),
(8);

-- FanTeam insertion

GO

insert into FanTeam (NFLFanID, TeamID, PrimaryTeam)
VALUES
(1, 11, 1),
(1, 24, 0), -- Tom Brady is a fan of New England Patriots and Tampa Bay Buccaneers, but Patriots is his primary team
(2, 19, 1),
(2, 12, 0),
(2, 4, 0),-- Aaron Rodgers is a fan of Green Bay Packers, New York Jets, and Pittsburgh Steelers, but Packers is his primary team
(3, 3, 1), -- Drew Brees is a fan New Orleans Saints (primary) and Los Angeles Chargers
(3, 16, 0),
(4, 14, 1); -- Patrick Mahomes is a fan of Kansas City Chiefs (primary)

-- Insert Test Data

select * from FanTeam;
select * from NFLFan;
select * from NFLAdmin;
select * from AppUser;


INSERT INTO Stadium (StadiumName, StadiumCityState, Capacity) VALUES
('M&T Bank Stadium', 'Baltimore, MD', 71008),
('Paycor Stadium', 'Cincinnati, OH', 65515),
('Huntington Bank Field', 'Cleveland, OH', 67431),
('Acrisure Stadium', 'Pittsburgh, PA', 68400),
('NRG Stadium', 'Houston, TX', 72220),
('Lucas Oil Stadium', 'Indianapolis, IN', 67000),
('EverBank Stadium', 'Jacksonville, FL', 62000),
('Nissan Stadium', 'Nashville, TN', 69143),
('Geodis Park', 'Nashville, TN', 30000), -- Titans temporary while Nissan demolished/rebuilt
('Highmark Stadium', 'Orchard Park, NY', 71608),
('Gillette Stadium', 'Foxborough, MA', 65878),
('MetLife Stadium', 'East Rutherford, NJ', 82500), -- Giants share with Jets
('Empower Field at Mile High', 'Denver, CO', 76125),
('GEHA Field at Arrowhead Stadium', 'Kansas City, MO', 76416),
('Allegiant Stadium', 'Las Vegas, NV', 65000),
('SoFi Stadium', 'Inglewood, CA', 70240), --Rams share with Chargers
('Soldier Field', 'Chicago, IL', 61500),
('Ford Field', 'Detroit, MI', 65000),
('Lambeau Field', 'Green Bay, WI', 81441),
('U.S. Bank Stadium', 'Minneapolis, MN', 66860),
('Mercedes-Benz Stadium', 'Atlanta, GA', 71000),
('Bank of America Stadium', 'Charlotte, NC', 74867),
('Caesars Superdome', 'New Orleans, LA', 73208),
('Raymond James Stadium', 'Tampa, FL', 69218),
('AT&T Stadium', 'Arlington, TX', 80000),
('Lincoln Financial Field', 'Philadelphia, PA', 69796),
('Northwest Stadium', 'Landover, MD', 67617),
('State Farm Stadium', 'Glendale, AZ', 63400),
('Levi''s Stadium', 'Santa Clara, CA', 68500),
('Lumen Field', 'Seattle, WA', 69000),
('Oakland Coliseum', 'Oakland, CA', 56057), -- Raiders immediate past
('Jack Murphy/Qualcomm Stadium', 'San Diego, CA', 70561), -- Chargers immediate past
('Hard Rock Stadium', 'Miami Gardens, FL', 65300);

-- select * from Stadium order by StadiumID;

go

INSERT INTO TeamStadium 
(TeamID, StadiumID, StartYear, EndYear) 
VALUES 
-- Baltimore Ravens
(1, 1, 1998, NULL),
-- Cincinnati Bengals
(2, 2, 2000, NULL),
-- Cleveland Browns
(3, 3, 1999, NULL),
-- Pittsburgh Steelers
(4, 4, 2001, NULL),
-- Houston Texans
(5, 5, 2002, NULL),
-- Indianapolis Colts
(6, 6, 2008, NULL),
-- Jacksonville Jaguars
(7, 7, 1995, NULL),
-- Tennessee Titans (Nissan Stadium, now being replaced)
(8, 8, 1999, 2026),
-- Tennessee Titans (temporary home at Geodis Park while new stadium is built)
(8, 9, 2027, NULL),
-- Buffalo Bills
(9, 10, 2026, NULL),
-- New England Patriots
(11, 11, 2002, NULL),
-- New York Jets (MetLife)
(12, 12, 2010, NULL),
-- Denver Broncos
(13, 13, 2001, NULL),
-- Kansas City Chiefs
(14, 14, 1972, NULL),
-- Las Vegas Raiders (Allegiant)
(15, 15, 2020, NULL),
-- Las Vegas Raiders immediate past (Oakland Coliseum)
(15, 31, 1966, 2019),
-- Los Angeles Chargers (SoFi)
(16, 16, 2020, NULL),
-- Los Angeles Chargers immediate past (Qualcomm/StubHub)
(16, 32, 1967, 2016),
-- Chicago Bears
(17, 17, 1971, NULL),
-- Detroit Lions
(18, 18, 2002, NULL),
-- Green Bay Packers
(19, 19, 1957, NULL),
-- Minnesota Vikings
(20, 20, 2016, NULL),
-- Atlanta Falcons
(21, 21, 2017, NULL),
-- Carolina Panthers
(22, 22, 1996, NULL),
-- New Orleans Saints
(23, 23, 1975, NULL),
-- Tampa Bay Buccaneers
(24, 24, 1998, NULL),
-- Dallas Cowboys
(25, 25, 2009, NULL),
-- New York Giants (MetLife)
(26, 12, 2010, NULL),
-- Philadelphia Eagles
(27, 26, 2003, NULL),
-- Washington Commanders
(28, 27, 1997, NULL),
-- Arizona Cardinals
(29, 28, 2006, NULL),
-- Los Angeles Rams (SoFi)
(30, 16, 2020, NULL),
-- San Francisco 49ers
(31, 29, 2014, NULL),
-- Seattle Seahawks
(32, 30, 2002, NULL),
-- Miami Dolphins
(10, 33, 1987, NULL);

--select * from TeamStadium;
