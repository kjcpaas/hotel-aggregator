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
