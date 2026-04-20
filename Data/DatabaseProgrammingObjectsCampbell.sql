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


--procFindAllTeamsInMyConferenceDivision

--Provide team name, then receive all teams in the same division and conference (minus specified team)

GO

create or alter procedure [dbo].[procFindAllTeamsInMyConferenceDivision]
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

-- validate user proc

GO

create or alter procedure procValidateUser
(
  @Email NVARCHAR(100),
  @PasswordHash NVARCHAR(200)
)
AS
BEGIN
  select AppUserID, Firstname + ' ' + Lastname as FullName, UserRole
  from AppUser
  where Email = @Email and 
  PasswordHash = Convert(VARBINARY(200), @PasswordHash, 1);
END

-- execute [dbo].[procValidateUser] @Email = 'tom.brady@example.com', @PasswordHash = '0x01';


-- Get teams for specified fan proc

GO

create or alter procedure procGetTeamsForSpecifiedFan
(
  @NFLFanID INT
)
AS
BEGIN
    select T.Tname, CD.Conference, CD.Division, T.Tcolors, FT.PrimaryTeam
    from NFLFan F
            inner join FanTeam FT
            on F.NFLFanID = FT.NFLFanID
            inner join Team T
            on FT.TeamID = T.TeamID
            inner join ConferenceDivision CD
            on T.CDID = CD.CDID
    where F.NFLFanID = @NFLFanID;
END;

select * from NFLFan;
-- execute procGetTeamsForSpecifiedFan @NFLFanID = 1

-- extra teams by color proc 


go 

create or alter procedure procGetTeamsByColor
(
    @TeamColor NVARCHAR(50)
)
as
BEGIN
    select t.tname as Team_Name, t.tcolors as Colors        -- renaming tables can help the name calling issue on api side
        from Team t
    where t.tcolors like '%'+@TeamColor+'%'
END

-- execute procGetTeamsByColor @TeamColor = 'Blue'