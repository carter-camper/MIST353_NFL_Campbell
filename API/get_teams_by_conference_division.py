from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference, division):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("EXEC procGetTeamsByConferenceDivision @Conference = ?, @Division = ?", (conference, division))
    rows = cursor.fetchall()
    conn.close()

    # convert rows to a list of dictionaries
    results = [
        {
            "TeamName": row.tname,
            "Conference": row.Conference,
            "Division": row.Division,
            "TeamColors": row.Tcolors
        }
        for row in rows
    ]

    return {"data": results}