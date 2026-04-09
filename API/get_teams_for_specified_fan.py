from get_db_connection import get_db_connection
def get_teams_for_specified_fan(
    NFLFanID: int
):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("{call procGetTeamsForSpecifiedFan(?)}", (NFLFanID,))
    rows = cursor.fetchall()
    conn.close()

    # convert rows to a list of dictionaries
    results = [
        {
            "TeamName": row.Tname,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.Tcolors
        }
        for row in rows
    ]

    return {"data": results}