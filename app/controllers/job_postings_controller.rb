class JobPostingsController < ApplicationController
  def index
    JobPosting.fetch_mail
  end
end
