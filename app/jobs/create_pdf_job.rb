class CreatePdfJob < ApplicationJob
    queue_as :default

    def perform(id)
        resume = Resume.find(id)
        pdf = WickedPdf.new.pdf_from_string(
            ApplicationMailer.new.render_to_string(
                pdf: 'todo', 
                template: 'resume_mailer/resume_pdf.html.erb', 
                layout: 'pdf.html', 
                locals: { resume: resume }
            ), 
            header: {
                content: ApplicationMailer.new.render_to_string(template: 'resumes/header.html.erb'),
                spacing: 1,
                line: true,
            },
            footer: {
                content: ApplicationMailer.new.render_to_string(template: 'resumes/footer.html.erb'),
                spacing: 1,
                line: true,
                font_size: '8',
                right: 'page [page] of [topage]' #page number
            } 
        )
        ResumeJob.perform_later(pdf, id)
    end
end
