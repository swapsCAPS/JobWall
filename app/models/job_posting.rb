class JobPosting < ApplicationRecord
  belongs_to :company
  validates :job_title, presence: true, length: { maximum: 64 }
  validates :company, presence: true

  def self.fetch_mail
    require 'gmail'
    puts "#{Time.now} fetching mail"
    Gmail.connect( ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD']) do |gmail|
      gmail.inbox.find(:unread).each do |e|
        company = Company.find_or_initialize_by(name: e.message.From.to_s)
        if company.save
          jb = JobPosting.find_or_initialize_by(job_title: e.subject, company: company)
          if jb.save
            e.read!
            puts puts jb.to_yaml
          else
            puts jb.errors.to_yaml
          end
        else
          puts company.errors.to_yaml
        end
      end
    end
  end

end
