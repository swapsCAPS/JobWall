require 'gmail'

class JobPosting < ApplicationRecord
  belongs_to :company
  validates :job_title, presence: true, length: { maximum: 64 }
  validates :company, presence: true

  def self.fetch_mail
    puts "#{Time.now} fetching mail"
    # Connect to gmail using the gmail gem
    Gmail.connect( ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD']) do |gmail|
      # Find all unread mails and loop over them
      gmail.inbox.find(:unread).each do |e|
        # Create company record unless it exists
        company = Company.find_or_initialize_by(name: e.message.From.to_s)
        if company.save
          # Create job posting record unless it exists
          jb = JobPosting.find_or_initialize_by(job_title: e.subject, company: company)
          if jb.save
            # Set gmail message to 'read'
            e.read!
            puts puts jb.to_yaml
          end
        end
        # Log errors
        if jb.errors
          puts jb.errors.to_yaml
        end
        if company.errors
          puts company.errors.to_yaml
        end
      end
    end
  end
end
