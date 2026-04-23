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



GO

create or alter procedure procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT -- admin who scheduled game
)

AS
BEGIN
    -- store NFLAdminID in context so trigger can access it when inserting into AdminChangesTracker
    DECLARE @context VARBINARY(128) = cast(@NFLAdminID as VARBINARY(128));
    set context_info @context;

    insert into Game (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END

-- trigger to capture changes to the Game table made by NFLAdmin
-- 1. events: are INSERT, UPDATE, DELETE
-- 2. action: insert into AdminChangesTracker

go

create or alter trigger trgTrackChangesOnSchedulingGame
on Game
after INSERT

AS
begin
    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR(50);
    declare @ChangeDescription NVARCHAR(500);
    declare @GameRound NVARCHAR(50);
    declare @GameDate DATE;
    declare @GameStartTime TIME;
    declare @StadiumID INT;
    declare @StadiumName NVARCHAR(100);
    declare @HomeTeamID INT;
    declare @AwayTeamID INT;
    declare @HomeTeamName NVARCHAR(100);
    declare @AwayTeamName NVARCHAR(100);
    declare @AdminFullName NVARCHAR(100);

    --get admin ID from context
    set @NFLAdminID = convert(int, convert(binary(4), context_info()));

    --get GameID
    select @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate,
        @GameStartTime = GameStartTime, @HomeTeamID = HomeTeamID, @AwayTeamID = AwayTeamID, @StadiumID = StadiumID
    from inserted;

    select @HomeTeamName = Tname from Team where TeamID = @HomeTeamID;
    select @AwayTeamName = Tname from Team where TeamID = @AwayTeamID;
    select @StadiumName = StadiumName from Stadium where StadiumID = @StadiumID;
    select @AdminFullName = Firstname + ' ' + Lastname from AppUser where AppUserID = @NFLAdminID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = @AdminFullName + ' scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(50)) + ': ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + cast(@GameDate as NVARCHAR(50)) + ' at ' + @StadiumName + ' during round ' + @GameRound

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END

/*

GameRound: 'Wild Card', HomeTeamID: 22, AwayTeamID: 30, GameDate: '2026-01-10', GameStartTime: '16:30', StadiumID: 22, 
NFLAdminID for scheduling: 5 (Bill Belichick)

execute procScheduleGame 
    @HomeTeamID = 22, 
    @AwayTeamID = 30, 
    @GameRound = 'Wild Card', 
    @GameDate = '2026-01-10', 
    @GameStartTime = '16:30', 
    @StadiumID = 22, 
    @NFLAdminID = 5;

GameRound: 'Wild Card', HomeTeamID: 17, AwayTeamID: 19, GameDate: '2026-01-10', GameStartTime: '20:00', StadiumID: 17,
NFLAdminID for scheduling: 6 (Sean McVay)

execute procScheduleGame 
    @HomeTeamID = 17, 
    @AwayTeamID = 19, 
    @GameRound = 'Wild Card', 
    @GameDate = '2026-01-10', 
    @GameStartTime = '20:00', 
    @StadiumID = 17, 
    @NFLAdminID = 6;

select * from Game;
select * from AdminChangesTracker;

*/