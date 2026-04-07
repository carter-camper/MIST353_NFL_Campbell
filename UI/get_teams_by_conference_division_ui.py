import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.subheader("Get Teams by Conference and Division")
    #conference = st.selectbox("Select Conference:", ["", "AFC", "NFC"])
    #division = st.selectbox("Select Division:", ["", "East", "West", "North", "South"])


    conference = st.text_input("Enter Conference (AFC or NFC):")
    division = st.text_input("Enter Division (East, West, North, South):")

    if st.button("Fetch Teams"):

      input_params = {}
      if conference.strip():
          input_params["conference"] = conference
      if division.strip():
          input_params["division"] = division
      # define function fetch_data
      df = fetch_data("get_teams_by_conference_division/", input_params)

      if df is not None and not df.empty:
            st.subheader(f"Teams in the {conference} Conference and {division} Division:")
            st.dataframe(df, use_container_width=True, hide_index=True)
      else:
            st.info(f"No teams found in the {conference} Conference and {division} Division.")