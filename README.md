# rails-pdf-playground

Running
    ruby '2.5.3'
    gem 'rails', '~> 5.2.2'

Tutorial sources: https://www.pdftron.com/blog/rails/how-to-generate-pdf-with-ruby-on-rails/

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

#Step 6 Deployment, ensure pdf assets precompile
file: config/initializers/assets.rb
    Rails.application.config.assets.precompile += %w( invoice.scss )

^ not sure if applicable