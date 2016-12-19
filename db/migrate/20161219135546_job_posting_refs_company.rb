class JobPostingRefsCompany < ActiveRecord::Migration[5.0]
  def change
     add_reference :job_postings, :company, foreign_key: true
  end
end
