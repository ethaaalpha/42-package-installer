#!/bin/bash
set -e

export APPS_SERVER=/home/${USER}/sgoinfre/apps/
export APPS_LOCAL=/home/${USER}/apps/

TAR_OPT="--strip-components 1"

function apps {
    mkdir -p $APPS_SERVER
    mkdir -p $APPS_LOCAL
    cd $APPS_SERVER

	mkdir -p java
	wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz -O java.tar.gz
	tar -xf java.tar.gz -C java $TAR_OPT
	rm -rf java.tar.gz

	mkdir -p flutter
	wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz -O flutter.tar.xz
	tar -xf flutter.tar.xz -C flutter $TAR_OPT
	rm -rf flutter.tar.xz

	mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C homebrew

	mkdir -p m2
	wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz -O m2.tar.gz
	tar -xf m2.tar.gz -C m2 $TAR_OPT
	rm -rf m2.tar.gz

	mkdir -p android_studio
	wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz -O android_studio.tar.gz
	tar -xf android_studio.tar.gz -C android_studio $TAR_OPT
	rm -rf android_studio.tar.gz
}

function login {
   	mkdir -p ${APPS_LOCAL}
   	cp -a ${APPS_SERVER}* ${APPS_LOCAL}
}

function logout {
   	cp -a ${APPS_LOCAL}* ${APPS_SERVER}
   	rm -rf ${APPS_LOCAL}
}

function path {
    cat <<EOF >> $HOME/.zshrc

# Script related stuff
export JAVA_HOME="${APPS_LOCAL}java"
export JAVA_PATH="${APPS_LOCAL}java/bin"
export M2_HOME="${APPS_LOCAL}m2/bin"
export BREW_HOME="${APPS_LOCAL}homebrew/bin"
export FLUTTER="${APPS_LOCAL}flutter/bin"
export ANDROID_PATH="${APPS_LOCAL}android_studio"

export PATH="\$JAVA_PATH:\$M2_HOME:\$BREW_HOME:\$FLUTTER:\$ANDROID_PATH/bin:\$PATH"

# Android related stuff
export ANDROID_HOME="\$ANDROID_PATH/sdk"
export ANDROID_EMULATOR_HOME="\$ANDROID_PATH/emulator"
export ANDROID_AVD_HOME="\$ANDROID_PATH/avd"
export PATH="\$ANDROID_HOME:\$ANDROID_EMULATOR_HOME:\$ANDROID_AVD_HOME:\$PATH"

alias astudio="nohup bash \$ANDROID_PATH/bin/studio.sh &"
EOF
}

case "$1" in
    login)
        login
        ;;
    logout)
        logout
        ;;
    download)
        apps
        ;;
    path)
        path
        ;;
    *)
        cat <<EOF
Use ./manage.sh
    login: to copy application from sgoinfre to local
    logout: to copy local application to sgoinfre
    download: to install application on the sgoinfre
    path: export apps values to zshrc
EOF

esac
