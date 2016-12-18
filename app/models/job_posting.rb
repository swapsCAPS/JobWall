class JobPosting < ApplicationRecord
  def self.fetch_mail
    require 'gmail'
    puts "#{Time.now} fetching mail"
    gmail = Gmail.connect( ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD'])
    gmail.inbox.emails.each do |e|
      puts e.subject
    end
  end
end
