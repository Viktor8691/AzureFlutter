FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa default-jdk wget

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip
RUN unzip commandlinetools-linux-8512546_latest.zip && rm commandlinetools-linux-8512546_latest.zip
RUN mkdir Android/cmdline-tools
RUN mv cmdline-tools Android/cmdline-tools/tools
RUN cd Android/cmdline-tools/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/cmdline-tools/tools/bin && ./sdkmanager "build-tools;30.0.2" "patcher;v4" "platform-tools" "platforms;android-31" "sources;android-31"
ENV PATH "$PATH:/home/developer/Android/cmdline-tools/tools/bin:/home/developer/Android/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor