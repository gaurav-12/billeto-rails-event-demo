# Billeto Rails Event Demo
<img width="1316" height="446" alt="image" src="https://github.com/user-attachments/assets/f1dba87c-186d-4ca6-befb-7980ed22e4b6" />
<img width="1347" height="611" alt="image" src="https://github.com/user-attachments/assets/27faf4cb-561d-432a-a7c2-254c02908b97" />

## Environment/Requirements
**Note** that following were used for the development of this app, and can possibly be updated too
1. Ubuntu 22.04
2. ruby 3.2.0
3. Rails 7.2.3
4. psql (PostgreSQL) 14.23 (Ubuntu 14.23-0ubuntu0.22.04.1)

## Local Setup
1. Clone the repository
2. `bundle install`
3. `rails db:setup`
4. `rails db:migrate`
5. `cp .env.sample .env`
6. Update `.env` with the appropriate values for Billeto and Clerk APIs
7. Update `database.yml` with your local Postgres credentials

## Seed events
Call `events/sync` endpoint from Postman, Insomnia or any other API client, to sync public events from Billeto to local DB. **Note** that the endpoint currently requires "bearer" authentication from Clerk. If you wish to sync events without authentication then it can be added as exception in before action of events controller.

## Miscellaneous
1. Events can be deleted using destroy endpoint which is protected by Clerk and not accessible through the frontend yet.
2. TODO comments can be ignored for now and will (hopefully) be worked upon by a human.
3. No AI tools were used in the development of this application(VIBEKILL-CODING).
4. Tests are yet to be written for controller and model. Hopefully a clanker in near future will read this repo. and write them.
5. Have a good one!
