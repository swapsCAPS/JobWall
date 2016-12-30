require 'gmail'

class JobPosting < ApplicationRecord
  belongs_to :company
  validates :job_title, presence: true, length: { maximum: 64 }
  validates :company, presence: true

  def self.textFile
  end

  def self.fetch_mail
    puts "#{Time.now} fetching mail"
    # Connect to gmail using the gmail gem
    Gmail.connect( ENV['NJ_GMAIL_USERNAME'], ENV['NJ_GMAIL_PASSWORD']) do |gmail|
      # Find the first 10 unread mails and loop over them
      gmail.inbox.find(:unread).first(10).each do |e|
        # Create company record unless it exists
        company = Company.find_or_initialize_by(name: e.message.From.to_s)
        if company.save
          # Create job posting record unless it exists
          jb = JobPosting.find_or_initialize_by(job_title: e.subject, company: company)
          if jb.save
            # Set gmail message to 'read' if we are in production
            if Rails.env.production?
              e.read!
            end
            puts jb.to_yaml
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

  def company_name(sentence)
    dict = LinkParser::Dictionary.new
    sent = dict.parse(sentence)
    puts sent.diagram
    sent.object
  end
end
