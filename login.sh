#!/bin/bash

export APPS_SERVER=/home/${USER}/sgoinfre/apps/
export APPS_LOCAL=/home/${USER}/apps/

source ~/.bashrc
TAR_OPT="--strip-components 1"

function apps {
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
   	cp -r ${APPS_SERVER} ${APPS_LOCAL}
}

function logout {
   	cp -r ${APPS_LOCAL} ${APPS_SERVER}
   	rm -rf ${APPS_LOCAL}
}

#ajouter dans le bashrc
export JAVA_HOME=""
export JAVA_PATH=""
export M2_HOME=""
export BREW_HOME=""
export FLUTTER=""
export ANDROID_PATH=""

#pour android_studio
export ANDROID_HOME=${ANDROID_PATH}/sdk
export ANDROID_EMULATOR_HOME=${ANDROID_PATH}/emulator/
export ANDROID_AVD_HOME=${ANDROID_PATH}/avd/
alias astudio="nohup bash ${ANDROID_PATH}/bin/studio.sh &"
