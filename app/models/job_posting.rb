class JobPosting < ApplicationRecord
  def self.fetch_mail
    puts "#{Time.now} fetching mail"
  end
end
