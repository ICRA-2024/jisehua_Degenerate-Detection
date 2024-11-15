FROM osrf/ros:noetic-desktop-full

# Install Python and other dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a catkin workspace
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src

# Clone the required repositories
RUN git clone https://github.com/ICRA-2024/jisehua_Degenerate-Detection.git

WORKDIR /catkin_ws

# Build the workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Set up the entrypoint
ENTRYPOINT ["/bin/bash", "-c", "source devel/setup.bash && exec \"$@\"", "--"]
CMD ["bash"]
