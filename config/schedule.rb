# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']
env :NJ_GMAIL_USERNAME, ENV['NJ_GMAIL_USERNAME']
env :NJ_GMAIL_PASSWORD, ENV['NJ_GMAIL_PASSWORD']
set :output, "log/whenever.log"
set :environment, 'development'

every 24.hours do
  runner "JobPosting.fetch_mail"
end
