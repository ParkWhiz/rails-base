# rails-base
Base Docker build configuration for a rails web application.

## Building the Image

Run the build script from the root of the repo and follow the prompts:
```
./build.sh
```
Pass `--platform=linux/amd64` if you are running the script from Apple Silicon chips or other platform

Once you are ready to use the new image for an application, go to the repo for that application and update the `FROM` statement in the Dockerfile to point at the new version of the image.
