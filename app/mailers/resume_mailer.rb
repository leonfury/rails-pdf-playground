class ResumeMailer < ApplicationMailer
    def resume(id)
        resume = Resume.find(id)
        attachments["resume_#{id}.pdf"] = WickedPdf.new.pdf_from_string(
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
        mail(to: 'kliwaru@gmail.com', subject: 'Your todo PDF is attached')
    end
end
