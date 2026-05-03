import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.subheader("Get Teams for Specified Fan")

    if "app_user_id" not in st.session_state:
        st.warning("Please validate the user first.")
        return

    fan_id = st.text_input("Fan ID", value=st.session_state.app_user_id, disabled=True)

    if st.button("Fetch Teams"):
        input_params = {"NFLFanID": fan_id}
        df = fetch_data("get_teams_for_specified_fan/", input_params)

        if df is not None and not df.empty:
            st.subheader(f"User {fan_id}'s Teams:")
            st.dataframe(
                df,
                use_container_width=True,
                hide_index=True,
                column_config={
                    "PrimaryTeam": st.column_config.CheckboxColumn("Primary Team")
                }
            )
        else:
            st.info("No teams found for the specified user.")