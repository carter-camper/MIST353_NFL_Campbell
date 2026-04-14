import streamlit as st
from fetch_data import fetch_data

def get_teams_by_colors_ui():
    st.subheader("Get Teams by Color")
    color = st.text_input("Enter Color:")

    if st.button("Fetch Teams"):
        if not color.strip():
            st.warning("Please enter a color.")
        else:
            input_params = {}
            input_params["color"] = color.strip()
            # define function fetch_data
            df = fetch_data("get_teams_by_color/", input_params)

            if df is not None and not df.empty:
                dark_colors = {"black", "navy", "darkblue", "darkgreen", "maroon", "purple", "indigo", "darkred", "brown"}
                text_color = "white" if color.strip().lower() in dark_colors else "black"

                st.markdown(f"### Teams with <span style='background-color:{color}; color: {text_color}; padding: 2px 6px; border-radius: 4px;'>{color}</span> in their colors:", unsafe_allow_html=True)
                st.dataframe(df, use_container_width=True, hide_index=True)
            else:
                st.info(f"No teams found with {color} in their colors")