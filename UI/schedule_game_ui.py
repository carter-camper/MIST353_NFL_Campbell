import streamlit as st
from fetch_data import post_data, fetch_data
from datetime import date, time


def schedule_game_ui():
    st.header("Schedule a New Game")

    if "app_user_id" not in st.session_state:
        st.warning("Please log in via 'Validate User' before scheduling a game.")
        return
    if st.session_state.get("app_user_role") != "NFLAdmin":
        st.error("Only NFL Admins can schedule games.")
        return

    parameters ={}
    teams_df = fetch_data("get_all_teams/", parameters)
    stadiums_df = fetch_data("get_all_stadiums/", parameters)

    GAME_ROUNDS = ["Wild Card", "Divisional", "Conference", "Super Bowl"]
    
    # Create dropdown for home team, away team, and stadium
    team_options = dict(zip(teams_df["TeamName"], teams_df["TeamID"]))
    stadium_options = dict(zip(stadiums_df["StadiumName"], stadiums_df["StadiumID"]))

    
    home_team_name = st.selectbox("Select Home Team", options=team_options.keys())
    away_team_name = st.selectbox("Select Away Team", options=team_options.keys())
    stadium_name = st.selectbox("Select Stadium", options=stadium_options.keys())
    game_round = st.selectbox("Select Game Round", GAME_ROUNDS)

    # Get user input for game date and time
    game_date = st.date_input("Select Game Date", min_value=date.today())
    game_time = st.time_input("Select Game Time", value=time(13, 0))

    # Schedule the game
    if st.button("Schedule Game"):
        if home_team_name == away_team_name:
            st.warning("Home Team and Away Team cannot be the same. Please select different teams.")
            return
        
        home_team_id = team_options[home_team_name]
        away_team_id = team_options[away_team_name]
        stadium_id = stadium_options[stadium_name]

        parameters = {}
        parameters["HomeTeamID"] = home_team_id
        parameters["AwayTeamID"] = away_team_id
        parameters["GameDate"] = game_date.isoformat()
        parameters["GameStartTime"] = game_time.isoformat()
        parameters["StadiumID"] = stadium_id
        parameters["GameRound"] = game_round
        parameters["NFLAdminID"] = st.session_state.app_user_id

        response = post_data("schedule_game/", parameters)

        if response is not None and "status_message" in response:
            st.info(response["status_message"])
        else:
            st.error("An error occurred while scheduling the game. Please try again.")







# def schedule_game_ui():
#     # Get user input for scheduling a game
#     st.header("Schedule a New Game")
#     HomeTeamID = st.number_input("Enter Home Team ID:", min_value=None, step=1)
#     AwayTeamID = st.number_input("Enter Away Team ID:", min_value=None, step=1)
#     GameRound = st.text_input("Enter Game Round:")
#     GameDate = st.date_input("Enter Game Date:")
#     GameStartTime = st.time_input("Enter Game Start Time:")
#     StadiumID = st.number_input("Enter Stadium ID:", min_value=None, step=1)
#     NFLAdminID = st.number_input("Enter NFL Admin ID:", min_value=None, step=1)


    
#     if st.button("Schedule Game"):
    
#     # Call the API to schedule the game
#         result = post_data("schedule_game/", {
#             "HomeTeamID": HomeTeamID,
#             "AwayTeamID": AwayTeamID,
#             "GameRound": GameRound,
#             "GameDate": GameDate.isoformat(),
#             "GameStartTime": GameStartTime.isoformat(),
#             "StadiumID": StadiumID,
#             "NFLAdminID": NFLAdminID
#         },
#         method="POST"
#         ) 
#         st.write(result)
