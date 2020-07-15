# Church Calendar API

[![Build Status](https://travis-ci.org/igneus/church-calendar-api.svg?branch=master)](https://travis-ci.org/igneus/church-calendar-api)

Browse Roman Catholic liturgical calendar through a web interface
or obtain it's data in JSON format through an API.

Powered by
[calendarium-romanum][caro] and
grape.

## Explore it on-line

Church Calendar API is a more or less RESTful read-only JSON API.

API documentation with URI examples and live links to API endpoints:
http://calapi.inadiutorium.cz/api-doc

## Running locally

Make sure you have Docker installed, then run:

```sh
docker-compose up
```

## Local Development of `calendarium-romanum`

If you need to work on the `calendarium-romanum` gem locally you can do so in the following way:

1. Clone down the `calendarium-romanum` app:
  ```sh
  git clone git@github.com:Lumen-de-Lumine/calendarium-romanum.git calendarium-romanum
  ```
2. Update the following lines in the `docker-compose.yml`
  ```sh
  # - ./calendarium-romanum:/home/app/webapp/calendarium-romanum
  # - .bundle_config:/home/app/webapp/.bundle/config
  ```
3. Modify the source of the `calendarium-romanum` and then restart via `docker-compose restart`

In short what the above does is the equivalent of running the following:

```sh
bundle config --local local.calendarium-romanum /path/to/calendarium-romanum
```

which allows for local gem modification without modifying the `Gemfile` or `Gemfile.lock` ([read more about this here if desired](https://rossta.net/blog/how-to-specify-local-ruby-gems-in-your-gemfile.html))

## Running your own instance on Heroku

The application works as is, you only need to create a new application
in your Heroku dashboard and push the code.

Typical reasons for running your own instance include:

* availability/reliability requirements
  (the [reference instance][calapi] is self-hosted by the author
  and only maintained as free time permits;
  it may be terminated at any time)
* very high traffic expected
* custom calendar data that cannot be released as open-source
  (e.g. because it is copyrighted by the diocese)
* required control over data and algorithm updates
  (the reference instance is updated without prior notice)

## Running specs

`$ rake test`

## Adding custom data

In order to add a new calendar:

1. put it's data file(s) in the `data` directory
2. create a new record in `config/calendars.yml`

## Release

The standard release command for this project is:
```
npm version [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease | from-git]
```

This command will:

1. Generate/update the Changelog
1. Bump the package version
1. Tag & pushing the commit


e.g.

```
npm version 1.2.17
npm version patch // 1.2.17 -> 1.2.18
```

## Client libraries

* Ruby: [calendarium-romanum-remote][caro_remote]

## License

GNU/LGPL 3 or later

[calapi]: http://calapi.inadiutorium.cz
[caro]: http://github.com/igneus/calendarium-romanum
[caro_data]: https://github.com/igneus/calendarium-romanum/tree/master/data
[caro_remote]: https://github.com/igneus/calendarium-romanum-remote
