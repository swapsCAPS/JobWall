require 'dotenv/tasks'

namespace :fetchmails do
  desc "Fetch mails and populate database"
  task :fetch => [:environment, :dotenv] do
    # things that require .env
    JobPosting.fetch_mail
  end
end
