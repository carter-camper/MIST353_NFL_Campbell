import streamlit as st
from fetch_data import post_data

def schedule_game_ui():
    # Get user input for scheduling a game
    st.header("Schedule a New Game")
    HomeTeamID = st.number_input("Enter Home Team ID:", min_value=None, step=1)
    AwayTeamID = st.number_input("Enter Away Team ID:", min_value=None, step=1)
    GameRound = st.text_input("Enter Game Round:")
    GameDate = st.date_input("Enter Game Date:")
    GameStartTime = st.time_input("Enter Game Start Time:")
    StadiumID = st.number_input("Enter Stadium ID:", min_value=None, step=1)
    NFLAdminID = st.number_input("Enter NFL Admin ID:", min_value=None, step=1)


    
    if st.button("Schedule Game"):
    
    # Call the API to schedule the game
        result = post_data("schedule_game/", {
            "HomeTeamID": HomeTeamID,
            "AwayTeamID": AwayTeamID,
            "GameRound": GameRound,
            "GameDate": GameDate.isoformat(),
            "GameStartTime": GameStartTime.isoformat(),
            "StadiumID": StadiumID,
            "NFLAdminID": NFLAdminID
        },
        method="POST"
        ) 
        st.write(result)
