class ResumeJob < ApplicationJob
    queue_as :default

    def perform(pdf, id)
        # Do something later
        s3 = Aws::S3::Resource.new(region:ENV['AWS_REGION'], :access_key_id => ENV['AWS_ID'], :secret_access_key => ENV['AWS_SECRET'])
        obj = s3.bucket(ENV['AWS_BUCKET']).object("pdf/resume/#{id}-#{Time.now()}.pdf")
        obj.put(body: pdf)
        # end
    end
end
