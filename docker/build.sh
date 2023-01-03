set -x

ALLOWED_PLATFORMS="tf torch"
SRC_IMAGE_TAG="cpu-py39"
TARGET_IMAGE_TAG="latest"
PLATFORM=""
GPU=""

function exists_in_list() {
  LIST=$1
  DELIMITER=$2
  VALUE=$3
  LIST_WHITESPACES=$(echo $LIST | tr "$DELIMITER" " ")
  for x in $LIST_WHITESPACES; do
    if [ "$x" = "$VALUE" ]; then
      return 0
    fi
  done
  return 1
}

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  --gpu)
    GPU=YES
    TARGET_IMAGE_TAG="latest-gpu"
    ;;
  --platform)
    # Override for the base image.
    shift
    PLATFORM=$1

    if not exists_in_list "$ALLOWED_PLATFORMS" " " "$PLATFORM"; then
      echo "Unknown $PLATFORM. Allowed platforms: $ALLOWED_PLATFORMS"
      exit 1
    fi

    ;;
  *)
    echo "Usage: build.sh [ --gpu ] --platform tf or torch"
    exit 1
    ;;
  esac
  shift
done

if [ "$GPU" == "YES" ]; then
  if [ "$PLATFORM" == "tf" ]; then
    SRC_IMAGE_TAG="gpu-py39-cu112"
  elif [ "$PLATFORM" == "torch" ]; then
    SRC_IMAGE_TAG="gpu-py39-cu117"
  else
    echo "Unknown $PLATFORM. Allowed platforms: $ALLOWED_PLATFORMS"
    exit 1
  fi
fi

docker build --rm --build-arg SRC_IMAGE_TAG="${SRC_IMAGE_TAG}" -t blaze-"${PLATFORM}":${TARGET_IMAGE_TAG} blaze-"${PLATFORM}"/
docker tag blaze-torch:latest-gpu 514352861371.dkr.ecr.ap-south-1.amazonaws.com/recsys/blaze-torch:latest-gpu
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 514352861371.dkr.ecr.ap-south-1.amazonaws.com
docker push 514352861371.dkr.ecr.ap-south-1.amazonaws.com/recsys/blaze-torch:latest-gpu
