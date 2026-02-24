-- 3 queries 
-- 1 each for ConferenceDivision and Team tables, and 1 join query

-- ConferenceDivision query (select all northern divisions)
select c.conference, c.division
from ConferenceDivision c
where Division = 'North';

-- Team query (selecting all teams in the AFC South)
select t.tname, t.tcityState, t.tcolors
from Team t
where CDID = 3;

-- Join query (selecting all teams and their conference/division)
select t.teamid, t.tname, t.tcityState, c.conference, c.division
from Team t 
inner join ConferenceDivision c on c.cdid=t.cdid
order by teamid;





