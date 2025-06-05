# rails-base
Base Docker build configuration for a rails web application.

## Building the Image

Run the build script from the root of the repo and follow the prompts:
```
./build.sh
```

Once you are ready to use the new image for an application, go to the repo for that application and update the `FROM` statement in the Dockerfile to point at the new version of the image.

## Notable container changelog

### Rails 3.0.2

* `rails-base:3.0.2_20210812134927`: Initial base container.
  * _Circle: `rails-base:3.0.2-circleci_20210813120627`_
* `parkwhiz/rails-base:3.0.2_20240501155324`: Adds jemalloc.
  * _Circle: `rails-base:3.0.2-circleci_20240501155741`_
* `rails-base:3.0.2_20240522143800`: Postgres 16 libraries.
  * _Circle: `rails-base:3.0.2-circleci_20240522144959`_
