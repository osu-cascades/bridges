# Bridging Out-of-School Time

A catalog of after school, weekend and summer activities for children and young adults in the High Desert Education Service District.

## Development

### Prerequisites
* PostgreSQL
    * `brew install postgresql`
* Ruby 2.6.3
    * `rvm use ruby-2.6.3`

### Getting Started
* Clone the repository
    * `git clone https://github.com/osu-cascades/bridges.git`
* Install the dependencies
    * `bundle install`
    * `yarn install`
* Create `.ruby-version` and `.ruby-gemset` files
    * After creating these, you must `cd` back into the app root to activate the use of the gemset
* Create a `.env` file following the format in [.env.example](./.env.example)
    * Obtain reCAPTCHA credentials following [these basic steps](https://developers.google.com/recaptcha/intro#overview)
* Ensure Postgres server is running
    * `brew services start postgres`
* Set up the database
    * `rails db:setup`
    * `rails db:migrate`
    * `rails db:seed`
* Run the tests
    * `rspec`
    *  View the test coverage at `./coverage/index.html`
* Run the application
    * `rails s`

## Heroku
* The application is hosted on Heroku in both a staging and production environment
    * Staging: https://hdesd-bridges-staging.herokuapp.com
    * Production: https://hdesd-bridges.herokuapp.com
* Set up the Heroku remotes in your `.git/config`
  * Once done, it should look similar to the following

```
[remote "origin"]
	url = https://github.com/osu-cascades/bridges.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
[branch "develop"]
	remote = origin
	merge = refs/heads/develop
[remote "production"]
	url = https://git.heroku.com/hdesd-bridges.git
	fetch = +refs/heads/*:refs/remotes/heroku/*
[remote "staging"]
	url = https://git.heroku.com/hdesd-bridges-staging.git
	fetch = +refs/heads/*:refs/remotes/heroku/*
```

### Helpful Commands

_REMOTE = staging or production_
* Deploy to Heroku
  * `git push REMOTE`
* Run Rails console
  * `heroku run rails console --remote REMOTE`
* View live logs
  * `heroku logs --remote REMOTE --tail`
* Migrate the database
    * `heroku run rails db:migrate --remote REMOTE`
* Set environment variables
    * `heroku config:set VARIABLE_NAME=VARIABLE_VALUE --remote REMOTE`
* Connect to PostgreSQL
    * `heroku pg:psql --remote REMOTE`

---
&copy; 2019 High Desert Education Service District. By Nathaniel Pierce and Yong Bakos.
