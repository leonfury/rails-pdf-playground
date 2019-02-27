class ResumeMailer < ApplicationMailer
    def resume(id, email)
        @pdf = true
        resume = Resume.find(id)
    
        pdf = WickedPdf.new.pdf_from_string(
            render_to_string(
                pdf: 'todo', 
                template: 'resume_mailer/resume_pdf.html.erb', 
                layout: 'pdf.html', 
                locals: { resume: resume }
            ), 
            header: {
                content: render_to_string(template: 'resumes/header.html.erb'),
                spacing: 1,
                line: true,
            },
            footer: {
                content: render_to_string(template: 'resumes/footer.html.erb'),
                spacing: 1,
                line: true,
                font_size: '8',
                right: 'page [page] of [topage]' #page number
            } 
        )

        # To add pdf to S3
        s3 = Aws::S3::Resource.new(region:ENV['AWS_REGION'], :access_key_id => ENV['AWS_ID'], :secret_access_key => ENV['AWS_SECRET'])
        obj = s3.bucket(ENV['AWS_BUCKET']).object("pdf/resume/#{id}-#{Time.now()}.pdf")
        obj.put(body: pdf)
        # end
        attachments["Resume_#{id}.pdf"] = pdf 
        mail(to: email, subject: 'Your Resume PDF is attached')
    end
end
