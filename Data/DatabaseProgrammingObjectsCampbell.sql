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


----------------------------------------------------------------------------------------------

/*
procGetTeamsByConferenceDivision

Provide conf. and div. , then recieve all teams in respective conf. and div.
If null, recieve all teams
*/

go

create or alter procedure [dbo].[procGetTeamsByConferenceDivision]
(
    @Conference NVARCHAR(50) = NULL,
    @Division NVARCHAR(50) = NULL
)
AS
BEGIN
    select tname, Tcolors, Conference, Division
    from team T
    inner join ConferenceDivision CD 
        on CD.CDID = T.CDID
    where Conference = isnull(@Conference, Conference) 
        and Division = isnull(@Division, Division)
END

-----------------------------------------------------


--procFindAllTeamsInMyDivisionAndCD

--Provide team name, then receive all teams in the same division and conference (minus specified team)

GO

create or alter procedure [dbo].[procFindAllTeamsInMyDivisionAndCD]
(
    @tname NVARCHAR(50) = NULL
)

AS

BEGIN

select OtherTeam.Tname, OtherCD.Conference, OtherCD.Division
from Team MyTeam 
inner join Team OtherTeam
    on MyTeam.CDID = OtherTeam.CDID
inner join ConferenceDivision MyCD 
    on MyCD.CDID = MyTeam.CDID
inner join ConferenceDivision OtherCD 
    on OtherCD.CDID = OtherTeam.CDID
where MyTeam.tname = @tname AND
    OtherTeam.tname != @tname;

END





