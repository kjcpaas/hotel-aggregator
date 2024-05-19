# Hotel Aggregator

This application works as an aggregator of hotels from different data sources.

Documentation for my work process is [here](docs/worklog.md).

The application is deployed on [Heroku](https://hotel-aggregator-2a3bebab4939.herokuapp.com/)

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

## Querying the server

The hotels endpoint is available via `/hotels`.

When no parameter is given, the list of all hotels will be returned.

Filtering parameters can be specified via query parameters e.g:

- `/hotels?id=:hotel_id`: returns a single (or no) hotel with the specified id
- `/hotels?destination_id=:destination_id`: returns a list of hotels in the destination
- `/hotels?id=:hotel_id&destination_id=:destination_id`: returns 400 error as server will only process at most 1 of these parameters.

## Miscellaneous

### Deployment

The application is deployed on [Heroku](https://hotel-aggregator-2a3bebab4939.herokuapp.com/)

### CI/CD pipeline

Pipeline is built using Github Actions to facilitate the following:
- Code quality via rubocop (barebones)
- Running tests
- Deploying to Heroku

## Performance considerations

I did not implement further performance improvements. However, search for "NOTES: performance" to see my notes around this.
