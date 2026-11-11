-- trigger trgUpdateTotalWins
go
create or alter trigger trgUpdateTotalWins
on Game
after Update
as
BEGIN
    declare @GameID int;
    select @GameID = GameID from inserted;
    update Team
    set TotalWins = TotalWins + 1
    where TeamID = (select WinningTeamID from Game where GameID = @GameID);
END

-- procedure procEnterScores

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[procEnterScores]
(
    @GameID INT,
    @HomeTeamScore INT,
    @AwayTeamScore INT,
    @NFLAdminID INT
)
AS
BEGIN
    -- store NFLAdminID in context so trigger can access it when inserting into AdminChangesTracker
    DECLARE @context VARBINARY(128) = cast(@NFLAdminID as VARBINARY(128));
    set context_info @context;

    update Game
    set HomeTeamScore = @HomeTeamScore, AwayTeamScore = @AwayTeamScore,
        WinningTeamID = case 
                        when @HomeTeamScore > @AwayTeamScore then HomeTeamID
                        when @AwayTeamScore > @HomeTeamScore then AwayTeamID
                        else null end
    where GameID = @GameID;
END
GO
