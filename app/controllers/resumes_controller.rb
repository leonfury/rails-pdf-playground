class ResumesController < ApplicationController
  before_action :set_resume, only: [:show, :edit, :update, :destroy, :download]

  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = Resume.all
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
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
  end

  def download
    ResumeMailer.resume(@resume.id).deliver_now
    redirect_to resume_path(@resume)
  end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # GET /resumes/1/edit
  def edit
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = Resume.new(resume_params)

    respond_to do |format|
      if @resume.save
        format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
        format.json { render :show, status: :created, location: @resume }
      else
        format.html { render :new }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy
    respond_to do |format|
      format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resume
      @resume = Resume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resume_params
      params.require(:resume).permit(
          :name,
          :phone,
          :address,
          :description,
          :objective,
          :experience,
          :photo,
      )
    end
end
