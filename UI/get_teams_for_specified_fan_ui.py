import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.subheader("Get Teams for Specified Fan")


    nflfanid = st.text_input("Enter NFL Fan ID:")
    if st.button("Fetch Teams"):

      input_params = {}
      if not nflfanid.strip():
          st.error("NFL Fan ID is required.")
      else:
          input_params["NFLFanID"] = nflfanid
      # define function fetch_data
      df = fetch_data("get_teams_for_specified_fan/", input_params)

      if df is not None and not df.empty:
            st.subheader(f"User {nflfanid}'s Teams:")
            st.dataframe(
                df,
                use_container_width=True,
                hide_index=True,
                column_config={
                    "PrimaryTeam": st.column_config.CheckboxColumn("Primary Team")
                }
            )
      else:
            st.info(f"No teams found for the specified user.")