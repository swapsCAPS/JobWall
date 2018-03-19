class JobPosting < ApplicationRecord
  belongs_to :company
  validates :job_title, presence: true, length: { maximum: 64 }
  validates :company, presence: true

  # def self.textFile
  # end

  def self.fetch_mail
    puts "#{Time.now} fetching mail"
    # Connect to gmail using the gmail gem
    Gmail.connect(NJ_GMAIL_USERNAME, NJ_GMAIL_PASSWORD) do |gmail|
      puts "Current enviorment: #{Rails.env.to_s}"
      puts "Unread e-mails: #{gmail.inbox.count(:unread)}"
      puts "Read e-mails: #{gmail.inbox.count(:read)}"
      puts "Total e-mails: #{gmail.inbox.count}"


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
  private
    def company_name(sentence)
      dict = LinkParser::Dictionary.new
      parseOptions = LinkParser::ParseOptions.new( spell_guessing_enabled: false, verbosity: 1 )
      sent = dict.parse(sentence, parseOptions)
      puts sent.inspect
      puts sent.diagram
      puts 'nouns:'
      puts sent.nouns
      puts 'verb:'
      puts sent.verb
      puts 'subject:'
      puts sent.subject || ''
      puts 'object:'
      puts sent.object || ''
      strip_unknown_suffix sent.subject
    end

    def strip_unknown_suffix(word)
      if unkown_word?(word)
        word[0, word.length - 3]
      end
    end

    def unkown_word?(word)
      if word[-3, 3].include? "[!]"
        true
      else
        false
      end
    end
end
