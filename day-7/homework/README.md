# Gigih BE - Module 3

*A Simple CRUD Food menu*

This folder contains the source code of homework for Module 3 Session 1

## Prepare the environment 

set environment variable for db.rb
we need DB_UID, DB_PASSWORD, DB_NAME

```bash
$ export DB_UID=YOUR_DB_USERNAME
```

```bash
$ export DB_PASSWORD=YOUR_DB_PASSWORD
```

```bash
$ export DB_NAMEYOUR_DB_NAME
```
## Prepare the database

Import sql dump to mysql

```bash
$ mysql -u USERNAME -p < food_oms_db.sql
```

## Running the Sintra

```bash
$ ruby web.rb
```