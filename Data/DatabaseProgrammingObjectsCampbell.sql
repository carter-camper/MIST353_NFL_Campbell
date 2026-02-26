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


------------------------------------------------------------

--class query--

go

create or alter procedure procGetTeamsByConferenceDivision
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

/*

execute procGetTeamsByConferenceDivision
    @Conference = 'AFC',
    @Division = 'North';

*/

------------------------------------------------------------

--find all teams in my team's division (user optionally provides team name)
--show tnmae, conf. and div.
go

create or alter procedure procGeTamsInMyDivision
(
    @tname NVARCHAR(50) = NULL
)
AS
BEGIN
    select tname, conference, division
    from team t
    inner join ConferenceDivision cd 
        on cd.cdid = t.cdid
    where Conference = isnull(@tname, tname) 
        and Division = 1;
END
---------------------------------------------------------------

GO

create or alter procedure FindAllTeamsInMyDivision
(
    @tname NVARCHAR(50) = NULL
)

AS

BEGIN

DECLARE @myTeamName NVARCHAR(50) = 'Steelers';

select OtherTeam.Tname
from Team MyTeam inner join Team OtherTeam
    on MyTeam.CDID = OtherTeam.CDID
where MyTeam.tname = @myTeamName AND
    OtherTeam.tname != @myTeamName;

END

------------------------------------------


--add the conf div
GO

create or alter procedure FindAllTeamsInMyDivision
(
    @tname NVARCHAR(50) = NULL
)

AS

DECLARE @myTeamName NVARCHAR(50) = 'Steelers';

select OtherTeam.Tname
from Team MyTeam inner join Team OtherTeam
    on MyTeam.CDID = OtherTeam.CDID
where MyTeam.tname = @myTeamName AND
    OtherTeam.tname != @myTeamName;









