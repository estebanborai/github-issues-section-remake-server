# github_issues_section_remake_server

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).

## Running Postgres Database with Docker
Build `Dockerfile`:
```bash
docker build -t github_issues_remake_db .
```

Run the builded image:
```bash
docker run -p 5432:5432 github_issues_remake_db:latest
```
## Running migrations with aqueduct
```bash
aqueduct db generate
```

## Updated database based on migration
```bash
aqueduct db upgrade --connect postgres://admin:root@localhost:4321/github_issues_remake
```
