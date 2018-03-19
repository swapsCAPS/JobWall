# NerdyJobs
#### Installation:
- ```brew install link-grammar``` (Mac OSX)
- ```install link-grammar: http://www.abisource.com/projects/link-grammar/#download``` (Ubuntu)
- ```git clone git@github.com:stofstik/JobWall.git```
- ```cd JobWall```
- ```bundle install```
- ```rails db:setup```
- ```Rename the .env.example file to .env```
- ```Add your own credentials to the .env file```

#### Start rails & create cron job:
- ```rails s```
- ```whenever --update-crontab```
