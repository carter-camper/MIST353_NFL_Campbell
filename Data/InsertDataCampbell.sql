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


select * from ConferenceDivision
order by CDID;

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

select * from Team
order by TeamID;






