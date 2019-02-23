class ResumeMailer < ApplicationMailer
    def resume(id, email)
        @pdf = true
        resume = Resume.find(id)
        attachments["Resume_#{id}.pdf"] = WickedPdf.new.pdf_from_string(
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
        mail(to: email, subject: 'Your Resume PDF is attached')
    end
end
