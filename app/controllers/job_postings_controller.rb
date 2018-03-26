class JobPostingsController < ApplicationController
  def index
    JobPosting.fetch_mail
    @job_postings = JobPosting.first(10)
  end
end
