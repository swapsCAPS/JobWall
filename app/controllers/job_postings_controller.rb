class JobPostingsController < ApplicationController
  def index
    JobPosting.fetch_mail
    @job_postings = JobPosting.all
  end
end
