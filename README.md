# rails-base
Base Docker build configuration for a rails web application.

## Building the Image

Run the build script from the root of the repo and follow the prompts:
```
./build.sh
```

(You will likely have to have a member of Dev Ops run it to actually push the tag to dockerhub, as the `devops` team is the only one with `Read & Write` access to the `rails-base` project.)

Once you are ready to use the new image for an application, go to the repo for that application and update the `FROM` statement in the Dockerfile to point at the new version of the image.

## Notable container changelog

### Rails 3.4.6

* `rails-base:ruby-3.4.6_20250930095710`: Initial base container.
  * _Circle: `rails-base:ruby-3.4.6-circleci_20251001103045`_

### Rails 3.0.2

* `rails-base:3.0.2_20210812134927`: Initial base container.
  * _Circle: `rails-base:3.0.2-circleci_20210813120627`_
* `parkwhiz/rails-base:3.0.2_20240501155324`: Adds jemalloc.
  * _Circle: `rails-base:3.0.2-circleci_20240501155741`_
* `rails-base:3.0.2_20240522143800`: Postgres 16 libraries.
  * _Circle: `rails-base:3.0.2-circleci_20240522144959`_
