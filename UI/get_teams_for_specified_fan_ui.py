import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.subheader("Get Teams for Specific User")


    nflfanid = st.text_input("Enter NFL Fan ID:")
    if st.button("Fetch Teams"):

      input_params = {}
      if nflfanid.strip():
          input_params["NFLFanID"] = nflfanid
      # define function fetch_data
      df = fetch_data("get_teams_for_specified_fan/", input_params)

      if df is not None and not df.empty:
            st.subheader(f"Teams for User:")
            st.dataframe(df, use_container_width=True, hide_index=True)
      else:
            st.info(f"No teams found for the specified user.")