#!/usr/bin/env bash 

###################### Colors ########################
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green

# Bold
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BCyan='\033[1;36m'        # Cyan

# Background
On_Red='\033[41m'         # Red

################## FILES ############################
JFXRT=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/jfxrt.jar
JFXSWT=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/jfxswt.jar
ANTJAVAFX=/usr/lib/jvm/java-8-openjdk-amd64/lib/ant-javafx.jar
JAVAFXMX=/usr/lib/jvm/java-8-openjdk-amd64/lib/javafx-mx.jar

is_root() {
    if ((EUID != 0)); then
    echo -e "
    ${On_Red} Root or Sudo  Required to run this script ( $(basename $0)) ${Color_Off}
        "
        exit
    fi
}


check_jfx_installtion() {
    echo ""
    echo -e "${BRed} Checking for Possible OpenJFX-8 installation ${Color_Off}"
    echo ""
    if [[ -f "$JFXRT" ]];
        then
        echo -e "${Green} $JFXRT  ==> file exists : ${BCyan}[OK] ${Color_Off}"
        else 
        echo -e "${Green} $JFXRT  ==> file doesn't exists : ${BCyan}[X] ${Color_Off}"
    fi
    if [[ -f "$JFXSWT" ]];
        then
        echo -e "${Green} $JFXSWT  ==> file exists : ${BCyan}[OK] ${Color_Off}"
        else
        echo -e "${Green} $JFXSWT  ==> file doesn't exists : ${BCyan}[X] ${Color_Off}"
    fi
    if [[ -f "$ANTJAVAFX" ]];
        then
        echo -e "${Green} $ANTJAVAFX  ==> file exists : ${BCyan}[OK] ${Color_Off}"
        else
        echo -e "${Green} $ANTJAVAFX  ==> file doesn't exists : ${BCyan}[X] ${Color_Off}"

    fi
    if [[ -f "$JAVAFXMX" ]];
        then
        echo -e "${Green} $JAVAFXMX  ==> file exists : ${BCyan}[OK] ${Color_Off}"
        else
        echo -e "${Green} $JAVAFXMX  ==> file doesn't exists : ${BCyan}[X] ${Color_Off}"
    fi
}

remove_old_jfx() {
    echo ""
    echo -e "${BRed} Warning : this will removes any Openjfx-8 installation at /usr/lib/jvm/java-8-openjdk-amd64 "
    echo ""
    if [[ -f "$JFXRT" ]];
        then
        rm -rfv ${JFXRT}
        else
        echo -e " ${JFXRT}  ==> file doesn't exists ..nothing to do"

    fi

    if [[ -f "$JFXSWT" ]];
        then
        rm -rfv ${JFXSWT}
        else
        echo -e " ${JFXSWT}  ==> file doesn't exists ..nothing to do"   
    fi

    if [[ -f "$ANTJAVAFX" ]];
        then
        rm -rfv ${ANTJAVAFX}
        else
        echo -e " ${ANTJAVAFX}  ==> file doesn't exists ..nothing to do"  
    fi

    if [[ -f "$JAVAFXMX" ]];
        then
        rm -rfv ${JAVAFXMX}
        else 
        echo -e " ${JAVAFXMX}  ==> file doesn't exists ..nothing to do"  
    fi
    echo -e "${Color_Off}"   
    echo ""
}


install_jfx() {
    echo ""
    echo -e "${BYellow} Trying to install openJFX-8 "
    cp -R sdk/rt/lib/* /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/
    cp sdk/lib/ant-javafx.jar /usr/lib/jvm/java-8-openjdk-amd64/lib/
    cp sdk/lib/javafx-mx.jar /usr/lib/jvm/java-8-openjdk-amd64/lib/
    echo -e " Successfully installed openJFX-8 ${Color_Off}"
    echo ""
}
show_build_info() {
    echo -e "
    ${Green} 
    gradle.gradleVersion: 4.8
    OS_NAME: linux
    OS_ARCH: amd64
    java.runtime.version: 1.8.0_265-8u265-b01-0ubuntu2~18.04-b01
    java version: 1.8.0_265
    java build number: 01
    jdk.runtime.version: 1.8.0_265-8u265-b01-0ubuntu2~18.04-b01
    jdk version: 1.8.0_265
    jdk build number: 01
    minimum java build number: 26
    CONF: Debug
    NUM_COMPILE_THREADS: 4
    COMPILE_TARGETS: linux
    COMPILE_FLAGS_FILES: buildSrc/linux.gradle
    HUDSON_JOB_NAME: not_hudson
    HUDSON_BUILD_NUMBER: 0000
    PROMOTED_BUILD_NUMBER: 00
    PRODUCT_NAME: OpenJFX
    RAW_VERSION: 8.0.999
    RELEASE_NAME: 8u999
    RELEASE_MILESTONE: ea
    UPDATE_STUB_CACHE: false
    "
}


LOGO="
=========================================================================

 ██████╗ ██████╗ ███████╗███╗   ██╗     ██╗███████╗██╗  ██╗      █████╗ 
██╔═══██╗██╔══██╗██╔════╝████╗  ██║     ██║██╔════╝╚██╗██╔╝     ██╔══██╗
██║   ██║██████╔╝█████╗  ██╔██╗ ██║     ██║█████╗   ╚███╔╝█████╗╚█████╔╝
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██   ██║██╔══╝   ██╔██╗╚════╝██╔══██╗
╚██████╔╝██║     ███████╗██║ ╚████║╚█████╔╝██║     ██╔╝ ██╗     ╚█████╔╝
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚════╝ ╚═╝     ╚═╝  ╚═╝      ╚════╝ 
=========================================================================
"

echo -e "${BRed} ${LOGO} ${Color_Off}"

main() {
    is_root
    echo -e "${BGreen}"
    PS3='Please enter main option: '
    while true; do
            echo ""
            options=("Check for OpenJFX installation" "Install OpenJFX" "Delete OpenJFX-8" "Show Info About this OpenJFX-8 build" )
            select opt in "${options[@]}"
            do
                case $opt in
                    "Check for OpenJFX installation")
                        check_jfx_installtion;
                        break;;
                    "Install OpenJFX")
                        install_jfx;
                        break;;
                    "Delete OpenJFX-8")
                        remove_old_jfx ;
                        break;;
                    "Show Info About this OpenJFX-8 build")
                        show_build_info;
                        break;;
                    *) echo "invalid option $REPLY";;
                esac
            done
            echo ""
            echo -e "${BGreen}Are we done?"
            select opt in "Yes" "No"; do
                echo ""
                case $REPLY in
                    1) break 2 ;;
                    2) break ;;
                    *) echo "Look, it's a simple question..." >&2
                esac
            done
        done
}


main
