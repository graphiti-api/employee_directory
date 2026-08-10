# Employee Directory

The canonical example app for [Graphiti](https://graphiti.dev) — a Rails API demonstrating Resources, relationships, filtering, sorting, pagination, statistics, and generated request/resource specs, running Graphiti 2.0 on Rails 8.

## Setup

Requires Ruby 3.3+.

- `bin/setup` (installs gems, creates and seeds the database)
- `bin/rails server`
- Visit [http://localhost:3000](http://localhost:3000) — it lands on the [Vandal](https://graphiti.dev/reference/vandal) schema explorer. Or hit the API directly: `curl localhost:3000/api/v1/employees?include=positions`

Run the test suite with `bundle exec rspec`.

## What's not here

This app has no authentication, so it doesn't demonstrate authorization. For scoping records, guarding attributes, and integrating Pundit, see the [Authorization guide](https://graphiti.dev/topics/authorization).
