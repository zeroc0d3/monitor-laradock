#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  DOCKER BUILDER SCRIPT
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  Repository : https://github.com/zeroc0d3/docker-framework
#  License    : MIT
# -----------------------------------------------------------------------------

TITLE="LARADOCK BUILDER SCRIPT"      # script name
VER="1.4.1"                          # script version
ENV="0"                              # container environment (0 = development, 1 = production)
SKIP_BUILD="0"                       # (0 = with build process, 1 = bypass build process)
REMOVE_CACHE="0"                     # (0 = using cache, 1 = no-cache)
RECREATE_CONTAINER="0"               # (0 = disable recreate container, 1 = force recreate container)
DAEMON_MODE="1"                      # (0 = disable daemon mode, 1 = running daemon mode / background)

USERNAME=`echo $USER`
PATH_HOME=`echo $HOME`

CONTAINER_PRODUCTION="grafana"
CONTAINER_DEVELOPMENT="grafana"

export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300

get_time() {
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
}

logo() {
  clear
  echo "\033[22;32m=======================================================================================\033[0m"
  echo "\033[22;31m '##::::::::::'###::::'########:::::'###::::'########:::'#######:::'######::'##:::'##: \033[0m"
  echo "\033[22;31m  ##:::::::::'## ##::: ##.... ##:::'## ##::: ##.... ##:'##.... ##:'##... ##: ##::'##:: \033[0m"
  echo "\033[22;31m  ##::::::::'##:. ##:: ##:::: ##::'##:. ##:: ##:::: ##: ##:::: ##: ##:::..:: ##:'##::: \033[0m"
  echo "\033[22;31m  ##:::::::'##:::. ##: ########::'##:::. ##: ##:::: ##: ##:::: ##: ##::::::: #####:::: \033[0m"
  echo "\033[22;31m  ##::::::: #########: ##.. ##::: #########: ##:::: ##: ##:::: ##: ##::::::: ##. ##::: \033[0m"
  echo "\033[22;31m  ##::::::: ##.... ##: ##::. ##:: ##.... ##: ##:::: ##: ##:::: ##: ##::: ##: ##:. ##:: \033[0m"
  echo "\033[22;31m  ########: ##:::: ##: ##:::. ##: ##:::: ##: ########::. #######::. ######:: ##::. ##: \033[0m"
  echo "\033[22;31m ........::..:::::..::..:::::..::..:::::..::........::::.......::::......:::..::::..:: \033[0m"
  echo "\033[22;32m---------------------------------------------------------------------------------------\033[0m"
  echo "\033[22;32m# $TITLE :: ver-$VER                                                                   \033[0m"
}

header() {
  logo
  echo "\033[22;32m=======================================================================================\033[0m"
  get_time
  echo "\033[22;31m# BEGIN PROCESS..... (Please Wait)  \033[0m"
  echo "\033[22;31m# Start at: $DATE  \033[0m\n"
}

footer() {
  echo "\033[22;32m=======================================================================================\033[0m"
  get_time
  echo "\033[22;31m# Finish at: $DATE  \033[0m"
  echo "\033[22;31m# END PROCESS.....  \033[0m\n"
}

build_env() {
  if [ "$ENV" = "0" ]
  then
    BUILD_ENV="$CONTAINER_DEVELOPMENT"
  else
    BUILD_ENV="$CONTAINER_PRODUCTION"
  fi
}

cache() {
  if [ "$REMOVE_CACHE" = "0" ]
  then
    CACHE=""
  else
    CACHE="--no-cache "
  fi
}

recreate() {
  if [ "$RECREATE_CONTAINER" = "0" ]
  then
    RECREATE=""
  else
    RECREATE="--force-recreate "
  fi
}

daemon_mode() {
  if [ "$DAEMON_MODE" = "0" ]
  then
    DAEMON=""
  else
    DAEMON="-d "
  fi
}

docker_build() {
  if [ "$SKIP_BUILD" = "0" ]
  then
    echo "--------------------------------------------------------------------------"
    get_time
    echo "\033[22;34m[ $DATE ] ##### Docker Compose: \033[0m                        "
    echo "\033[22;32m[ $DATE ]       docker-compose build $CACHE$BUILD_ENV \033[0m\n"

    ## MULTI CONTAINER
    ## ------------------------------
    ## for CONTAINER in $BUILD_ENV
    ## do
    ##   get_time
    ##   echo "--------------------------------------------------------------------------"
    ##   echo "\033[22;32m[ $DATE ]       docker-compose build $CONTAINER \033[0m        "
    ##   echo "--------------------------------------------------------------------------"
    ##   docker-compose build $CONTAINER
    ##   echo ""
    ## done

    ## SINGLE CONTAINER (test)
    ## ------------------------------
    get_time
    echo "--------------------------------------------------------------------------"
    echo "\033[22;32m[ $DATE ]       docker-compose build $BUILD_ENV \033[0m        "
    echo "--------------------------------------------------------------------------"
    docker-compose build $BUILD_ENV
    echo ""
  fi
}

docker_up() {
  daemon_mode
  echo ""
  echo "--------------------------------------------------------------------------"
  get_time
  echo "\033[22;34m[ $DATE ] ##### Docker Compose Up: \033[0m                     "
  echo "\033[22;32m[ $DATE ]       docker-compose up $RECREATE$BUILD_ENV \033[0m\n  "
  get_time
  echo "--------------------------------------------------------------------------"
  echo "\033[22;32m[ $DATE ]       docker-compose up $RECREATE$BUILD_ENV \033[0m "
  echo "--------------------------------------------------------------------------"
  docker-compose up $DAEMON $RECREATE$BUILD_ENV
  echo ""
}

main() {
  header
  cache
  recreate
  build_env
  docker_build
  docker_up
  footer
}

### START HERE ###
main $@
