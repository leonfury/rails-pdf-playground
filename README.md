# rails-pdf-playground

https://rails-pdf-playground.herokuapp.com/
Note: images are not stored persistently as static assets are stored locally for this project

Still In progress
- Attempting to render pdf with details from custom forms
- Pdf can be viewed and be attached in email

To do : saving rendered pdf to amazon s3 bucket
=============================================================================================================================

Running
    ruby '2.5.3'
    gem 'rails', '~> 5.2.2'

Tutorial sources: 
https://www.pdftron.com/blog/rails/how-to-generate-pdf-with-ruby-on-rails/
https://github.com/mileszs/wicked_pdf
https://berislavbabic.com/send-pdf-attachments-from-rails-with-wickedpdf-and-actionmailer/

#Step 1 Installing Dependcies
To gemfile
    gem 'jquery-rails'
    gem 'bootstrap', '~> 4.1.3'
    gem 'wicked_pdf'
    gem 'wkhtmltopdf-binary'
Terminal -> bundle install

#Step 2 Generate wicked_pdf initializer
Terminal -> rails g wicked_pdf
File created -> config/initializers/wicked_pdf.rb

#Step 3 Generate model

#Step 4 Implement format.pdf
To relevant controlelr method
    respond_to do |format|
        format.html
        format.pdf do
            render pdf: "Invoice No. #{@invoice.id}",
            page_size: 'A4',
            template: "invoices/show.html.erb",
            layout: "pdf.html",
            orientation: "Landscape", #or portrait
            lowquality: true,
            zoom: 1,
            dpi: 75
        end
    end

#Step 5 Create View File
Create app/views/layout/pdf.html.erb 
Note: doesn't seem to be able to inherit stylesheets in assets ~
Note: image tag has to be used as wicked_pdf_image_tag

#Step 6 Configure Controller to render pdf file on browser
Example: see resume controller    
    respond_to do |format|
        format.html
        format.pdf do
            render pdf: "Resume No. #{@resume.id}",
            page_size: 'A4',
            template: "resumes/show.html.erb",
            layout: "pdf.html",
            orientation: "Portrait",
            lowquality: true,
            zoom: 1,
            dpi: 75,
            header: {
                html: { template: 'resumes/header.html.erb' },
                spacing: 1,
                line: true,
            },
            footer: {
                html: { template: 'resumes/footer.html.erb' },
                spacing: 2,
                line: true,
                font_size: '8',
                right: 'page [page] of [topage]' #page number
            }
        end
    end

#Step 7 Configure email job to attach pdf file on email
Example: see resume_mailer
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