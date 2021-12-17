export RELEASE_VERSION=0.0.0-dev
export ROOT=$(realpath .)

include makefiles/utils.mk
include makefiles/main.mk
include makefiles/python.mk
include makefiles/java.mk
include makefiles/javascript.mk