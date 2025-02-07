# Usage: build.sh <theme_name>

SETUP_CONTAINER=stencil_init
RUNTIME_CONTAINER=stencil_dev

THEME="${1}"
THEME_DIRECTORY="$(pwd)/themes/${THEME}"

if [ -z "${THEME}" ]
  then
    echo "Please provide the theme name."
    exit
fi

if [ ! -d "${THEME_DIRECTORY}" ]
  then
    echo "Theme directory was not found: ${THEME_DIRECTORY}"
    exit
fi

[ "$(docker container ls -a | grep ${SETUP_CONTAINER})" ] \
  && docker image rm ${SETUP_CONTAINER}

docker build -t ${RUNTIME_CONTAINER} ./env/node_stencil \
  && docker run -it --name ${SETUP_CONTAINER}  -v ${THEME_DIRECTORY}:/theme -p3000:3000 ${RUNTIME_CONTAINER} init
