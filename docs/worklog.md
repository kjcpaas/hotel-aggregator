# Worklog

## Stack choice

As the company uses Ruby on Rails intensively, I decided to use Ruby as well to demonstrate my abilities with this language.

However, we only need a simple web server so we do not need most of what RoR offers. Hence, I decided to use **Sinatra** as it is more lightweight and provides enough functionality for what we need.

These other tools will be used:
- RSpec: For writing tests (will do TDD)
- HTTParty: For making HTTP requests to external sources
- Rubocop: For code quality (will just use the default configuration)
- Github: Code respository
- Github Actions: For setting up simple CI/CD pipeline
- Heroku: For deployment

Other tools may be added along the way as the need arise.

## Initial setup

For this part, we setup a simple web server with Sinatra. We will just provide a root path that returns a simple json message.
## Setup tools

For this part, we will setup Rubocop and Rspec quickly so we can next setup a simple CI/CD pipeline. We will do this first so we can smoothly push all changes later and ensure nothing breaks along the way.

The tools that will be installed are RSpec and Rubocop.

## Setup CI/CD

Using Github actions, we will setup the following:

### CI

- rubocop
- rspec

### Deployment

Deploy to Heroku. We will need to install a web server that will run our app on Heroku.

We will use `thin` as it is simple and lightweight.

**NOTE**: `thin` may run into installation issues on Mac. Run the following before running `bundle install`:

```
bundle config build.thin --with-cflags="-Wno-error=implicit-function-declaration"
```

## Build source integration

Next, we integrate with individual suppliers. We will use HTTParty to send request to the supplier APIs:
- https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme
- https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia
- https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies

## Standardizing the hotel structure

Each supplier has different formats of hotel data. For example, the field names are different like in hotel id, which can be `id`, `Id`, or `hotel_id`.

In addition, some have different structures like for amenities/facilities, which is categorized for Paperflies but not for others.

We have to create models to provide standard format for Hotel data so we can effectively facilitate the filtering and merging.

### Building standard models

We need to provide models for standard data structure.

### Mapping supplier data to standard data

After creating the standard models, we also need to map the data from the suppliers to the standard data structures.

## Implementing queries

Now that we have standardized data structure, we can proceed to implementing queries.

### Find by hotel ID

We need to filter the hotel list returned by each supplier by the id.

This should return 1 or nothing.

### Find by destination ID

We need to filter the hotel list returned by each supplier by the destination id.

This should return a list of hotels. It is an empty list when not hotels are found with the destination id.

## Merging individual records

Now that we have completed the data cleaning for each supplier, we will now need to merge individual hotel records.

The specification states that we aim to have *as complete information as possible*.

Hence these considerations are taken into account when merging.

- Hotel only is considered non-existent **if and only if** it is not in any of the supplier list. If it exists in at least one, we consider it as existent.
- nil values have the **lowest priority when merging**
- We will take the **longest** string as the most valid. We consider this as more "complete" information. In case of a tie, we choose randomly.
- For numbers, we will take the one with **more precision**, i.e. more decimal places. In case of a tie, we choose randomly
- For arrays, we will combine them and remove duplicates

We will not use domain knowledge (which is missing from the given information) to test validity as is required more complex data analysis that the specifications don't ask for.

Hence, if one supplier has the country "Japan" while the other has "Qatar", we will treat them **equally valid**. Otherwise, we will need to check the coordinates to figure out the correct country, which goes way beyond what the specifications ask, which goes way beyond what the specifications ask. Other fields have similar considerations and we will **not** handle those cases in this application.

## Merging array of objects

For array of objects like images or hotels, it requires additional consideration top of simply joining arrays and removing duplicates.

In these cases, we determine if 2 objects are the same by a "primary key", which in the case of hotel is the id, while it is the URL for images.

The strategy we can do here, is to:
- concatenate all arrays
- group by primary key
- apply individual merger (from previous part) to each group

With this, we are left without any duplicates and the well-tested merging logic we have developed applies.

## Exposing the functionality via API

Now that we have the functionalities, we will deploy it via api.

We will create a "/hotel" end point for this.
