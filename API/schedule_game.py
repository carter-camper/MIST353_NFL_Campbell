from get_db_connection import get_db_connection
import pymssql
from datetime import date, time
def schedule_game(
    HomeTeamID: int,
    AwayTeamID: int,
    GameRound: str,
    GameDate: date,
    GameStartTime: time,
    StadiumID: int,
    NFLAdminID: int

):
    conn = None
    cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(as_dict=True)
        cursor.execute("exec procScheduleGame %s, %s, %s, %s, %s, %s, %s", (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID, NFLAdminID))
        conn.commit()
        return {"status_message": "Game scheduled successfully."}
    except pymssql.OperationalError as e:
        if conn:
            conn.rollback()
        return {"status_message": f"Database connection error: {e}"}
    except Exception as e:
        if conn:
            conn.rollback()
        if "Unique key constraint " in str(e):
            return {"status_message": f"Error: Game already scheduled for this date and time: {e}"}
        else:
            return {"status_message": f"Error occurred: {e}"}
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()



