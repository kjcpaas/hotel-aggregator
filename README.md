 Hotel Aggregator

This application works as an aggregator of hotels from different data sources.

Documentation for my work process is [here](docs/worklog.md).

The application is deployed at: *TBD*

## Stack

Ruby: `3.3.1`
Web server: Sinatra

## Build the app

```
bundle install
```

**Note**: If you run into an error in Mac when installing `thin`, try running the line below before running `bundle install' again.

```
bundle config build.thin --with-cflags="-Wno-error=implicit-function-declaration"
```

## Run the server

```
bundle exec thin start
```

App is available at `http://localhost:3000`
