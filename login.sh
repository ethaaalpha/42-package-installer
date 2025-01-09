#!/bin/bash

export APPS_SERVER=/home/${USER}/sgoinfre/apps/
export APPS_LOCAL=/home/${USER}/apps/

source ~/.bashrc

function login() {
    mkdir -p ${APPS_LOCAL}
    cp -r ${APPS_SERVER} ${APPS_LOCAL}
}

function logout() {
    cp -r ${APPS_LOCAL} ${APPS_SERVER}
    rm -rf ${APPS_LOCAL}
}

#ajouter dans le bashrc
export JAVA_HOME=
export JAVA_PATH=
export M2_HOME=
export BREW_HOME=
export FLUTTER=
export ANDROID_PATH=

#pour android_studio
export ANDROID_HOME=${ANDROID_PATH}/sdk
export ANDROID_EMULATOR_HOME=${ANDROID_PATH}/emulator/
export ANDROID_AVD_HOME=${ANDROID_PATH}/avd/
alias astudio="nohup bash ${ANDROID_PATH}/bin/studio.sh &"
