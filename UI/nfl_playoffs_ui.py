import streamlit as st
from pathlib import Path
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
from validate_user_ui import validate_user_ui
from get_teams_for_specified_fan_ui import get_teams_for_specified_fan_ui
from get_teams_by_colors_ui import get_teams_by_colors_ui
from schedule_game_ui import schedule_game_ui
from get_all_changes_made_by_specified_admin_ui import get_all_changes_made_by_specified_admin_ui

col1, col2, col3 = st.columns([1, 2, 1])
with col2:
    st.image(str(Path(__file__).parent / "vintage_nfl.png"), width=250)


st.title("NFL Playoffs App")
st.write("Welcome to the NFL Playoffs App! Use the sidebar to navigate through different features and explore information about NFL teams, players, and playoff matchups.")

#Creating a sidebar for navigation
#Dropdown for nfl playoff functionalities

with st.sidebar:
  st.title("NFL Playoff Functionalities")
  api_endpoint = st.selectbox(
    "Select a functionality:",
    ["Get Teams by Conference and Division",
      "Get Teams in Same Conference and Division as Specified Team",
      "Validate User",
      "Get Teams for Specified Fan",
      "Get Teams by Color",
      "Schedule Game",
      "Get All Changes Made by Specified Admin"
      ]
  )

if api_endpoint == "Get Teams by Conference and Division":
   get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":
   get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Validate User":
   validate_user_ui()

elif api_endpoint == "Get Teams for Specified Fan":
   get_teams_for_specified_fan_ui()

elif api_endpoint == "Get Teams by Color":
   get_teams_by_colors_ui()

elif api_endpoint == "Schedule Game":
     if "app_user_id" not in st.session_state:
           st.warning("Please log in to access the Schedule a Game functionality.")
     elif st.session_state.app_user_role != "NFLAdmin":
           st.warning("Only users with the NFL Admin role can access the Schedule a Game functionality.")
     else:
          schedule_game_ui()

elif api_endpoint == "Get All Changes Made by Specified Admin":
     if "app_user_id" not in st.session_state:
           st.warning("Please log in to access this functionality.")
     elif st.session_state.app_user_role != "NFLAdmin":
           st.warning("Only users with the NFL Admin role can access this functionality.")
     else:
          get_all_changes_made_by_specified_admin_ui()

# import streamlit as st
# from pathlib import Path
# from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
# from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
# from validate_user_ui import validate_user_ui
# from get_teams_for_specified_fan_ui import get_teams_for_specified_fan_ui
# from get_teams_by_colors_ui import get_teams_by_colors_ui



# col1, col2, col3 = st.columns([1, 2, 1])
# with col2:
#     img_path = Path(__file__).parent / "vintage_nfl.png"
#     st.image(str(img_path), width=250)

# st.title("NFL Playoffs App")
# st.write("Welcome to the NFL Playoffs App! Use the buttons below to navigate through different features and explore information about NFL teams, players, and playoff matchups.")


# # Initialize session state
# if "page" not in st.session_state:
#     st.session_state.page = None



# st.divider()

# # Navigation buttons
# col1, col2, col3, col4, col5 = st.columns(5)

# st.markdown("""
#     <style>
#     div.stButton > button {
#         height: 80px;
#     }
#     </style>
# """, unsafe_allow_html=True)

# with col1:
#     if st.button("Teams by Conference & Division", use_container_width=True):
#         st.session_state.page = "conference_division"

# with col2:
#     if st.button("Teams in Same Conference & Division", use_container_width=True):
#         st.session_state.page = "same_conference_division"

# with col3:
#     if st.button("Validate User", use_container_width=True):
#         st.session_state.page = "validate_user"

# with col4:
#     if st.button("Teams for Specified Fan", use_container_width=True):
#         st.session_state.page = "fan_teams"

# with col5:
#     if st.button("Teams by Color", use_container_width=True):
#         st.session_state.page = "color"

# st.divider()



# # Render selected functionality
# if st.session_state.page == "conference_division":
#     get_teams_by_conference_division_ui()

# elif st.session_state.page == "same_conference_division":
#     get_teams_in_same_conference_division_as_specified_team_ui()

# elif st.session_state.page == "validate_user":
#     validate_user_ui()

# elif st.session_state.page == "fan_teams":
#     get_teams_for_specified_fan_ui()

# elif st.session_state.page == "color":
#     get_teams_by_colors_ui()

# else:
#     st.info("Select a functionality above to get started.")