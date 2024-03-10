import streamlit as st


st.header(":blue[Demo Streamlit App (SPCS)]", divider="blue")
st.caption(
    """This app was created by the **IT DSA Team** 
    to demo streamlit apps in a container."""
)
st.expander("Resources")
st.link_button(
    ":book: **Step by Step Guide** :point_right:",
    "https://docs.google.com/document/d/1LZIQ_qhHsmSdA2n01paV4ExZtouPQ7q0F8AcSBQaumU",
)

with st.sidebar:
    ":star: Welcome to the Demo :star:"
    st.write("**Click to animate** :point_down:")

    if st.button(":balloon:", use_container_width=True):
        st.balloons()
    elif st.button(":snowflake:", use_container_width=True):
        st.snow()
