# rails-pdf-playground

https://rails-pdf-playground.herokuapp.com/

Rails playground for PDF generation and attaching rendered PDF to emails

Note: Save rendered PDF to external cloud service


Running

ruby '2.5.3'

gem 'rails', '~> 5.2.2'

Tutorial sources: 
https://www.pdftron.com/blog/rails/how-to-generate-pdf-with-ruby-on-rails/

https://github.com/mileszs/wicked_pdf

https://berislavbabic.com/send-pdf-attachments-from-rails-with-wickedpdf-and-actionmailer/

#Step 1 Gemfile Dependcies
- gem 'jquery-rails'
- gem 'bootstrap', '~> 4.1.3'
- gem 'wkhtmltopdf-binary'
- gem 'wicked_pdf', github: 'mileszs/wicked_pdf'


#Step 2 Generate wicked_pdf initializer
Terminal -> rails g wicked_pdf
File created -> config/initializers/wicked_pdf.rb


#Step 3 Generate model


#Step 4 Configure Controller to render pdf file on browser
See controller resumes#show


#Step 5 Create View File
Create app/views/layout/pdf.html.erb 
Note: doesn't seem to be able to inherit stylesheets in assets ~
Note: image tag has to be used as wicked_pdf_image_tag


#Step 6 Configure email job to attach pdf file on email
See resume_mailer
