<div align="center">

<br>

  This is my solution to your API challenge. I decided to work in Rails and use PostgreSQL for the database. I enjoyed working through this problem, and I thank you for the opportunity to showcase my skills, to stretch my brain, and get some quality practice.

  One note: I would not normally leave so much logic within my controllers, it is not very great MVC. Unfortunately due to personal time constraints I just didn't get to refactor that and abstract some code out. I understand it might be rough on the eyeballs and tough to swallow for any serious rubyists, but if I have time later this week, I would enjoy fixing that flaw.

  If you have any questions feel free to reach out to me at jacqwhitmer@gmail.com. Enjoy!

---

## Table of Contents
|Links
|--- |
[Tools Used](#tools-used)
[Setup](#setup)
[Goals](#goals)
[Database Schema](#database-schema)
[API Endpoints](#api-endpoints)


## Tools Used

[<img alt="Ruby On Rails" src="https://img.shields.io/badge/RubyOnRails-flat--square?logo=ruby-on-rails&style=for-the-badge&color=black"/>](https://rubyonrails.org/)

[<img alt="Git" src="https://img.shields.io/badge/Git-flat--square?logo=git&style=for-the-badge&color=black"/>](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

[<img alt="PostgreSQL" src ="https://img.shields.io/badge/Postgres-flat--square?logo=postgres&style=for-the-badge&color=black"/>](https://www.postgresql.org/)

[<img alt="RSpec" src ="https://img.shields.io/badge/RSpec-flat--square?logo=rspec&style=for-the-badge&color=black"/>](https://github.com/rspec/rspec-rails)

</div>

<div align="center">

## Setup

</div>


  This project requires PostgreSQL, Ruby 2.7.2, Rails 6.1.4, and bundler

  * Fork this repository
  * From the command line, install dependencies and set up your DB:
      * `bundle install`
      * `bundle update`
      * `rails db:{drop,create,migrate,seed}`
  * Run the test suite with `rspec`
  * Run your development server with `rails s` to see the app in action.
  * To test POST and PATCH endpoints, I suggest using POSTMAN while running your rails server. Use the URL: "/localhost:3000/api/v1/..." JSON Contract can be found in endpoints section


<div align="center">

## Goals

</div>

What does it need to do?

Background

Our users have points in their accounts. Users only see a single balance in their accounts. But for reporting purposes we actually track their points per payer/partner.

In our system, each transaction record contains: payer (string), points (integer), timestamp (date). For earning points it is easy to assign a payer, we know which actions earned the points. And thus which partner should be paying for the points.

When a user spends points, they don't know or care which payer the points come from. But, our accounting team does care how the points are spent. There are two rules for determining what points to "spend" first:
- We want the oldest points to be spent first (oldest based on transaction timestamp, not the order they’re received)
- We want no payer's points to go negative.

We expect your web service to provide routes that:
- Add transactions for a specific payer and date.
- Spend points using the rules above and return a list of { "payer": <string>, "points": <integer> } for each call.
- Return all payer point balances.
Note:
- We are not defining specific requests/responses. Defining these is part of the exercise.
- We don’t expect you to use any durable data store. Storing transactions in memory is acceptable for the exercise.

<div align="center">

## Database Schema

<img src="https://user-images.githubusercontent.com/78382113/148159378-1c7e9d00-2dc4-411a-8bdd-6d657999ce97.png">

</div>


## API Endpoints

<div align="left">

* POST to `/api/v1/transactions`
  - accepts the following body:
  ```
    {
      "payer": "payer_name",
      "points": points,
      "timestamps": "YYYY-MM-DDTHH:MM:SSZ"
    }
  ```
  - returns the following body:
  ```
  {
    data: {
      attributes: {
        "payer": "payer_name",
        "points": "points",
        "timestamps": "YYYY-MM-DDTHH:MM:SSZ",
        "id": "id",
        "type": "transaction",
        "created_at": "timestamp",
        "updated_at": "timestamp"
      }
    }
  }
  ```
* GET to `/api/v1/balances`
 - returns the following body:
 ```
   {
    "balances": [
      {
        "id": "id",
        "payer": "payer",
        "points": "points",
        "created_at": "timestamp",
        "updated_at": "timestamp"
      },
      {
        "id": "id",
        "payer": "payer",
        "points": "points",
        "created_at": "timestamp",
        "updated_at": "timestamp"
      },
      {
        "id": "id",
        "payer": "payer",
        "points": "points",
        "created_at": "timestamp",
        "updated_at": "timestamp"
      }...
    ]
  }
 ```

 * PATCH to `/api/v1/balances`
 - accepts the following body:
 ```
  {
    "points": "points"
  }
 ```

 - returns the following body:
 ```
 {
   "payer": "-points",
   "payer": "-points",
   "payer": "-points"....
 }
 ```
 </div>
