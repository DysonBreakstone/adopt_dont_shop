class ApplicationsController < ApplicationController
  def new
    # @application = Application.find(params[:id])
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @searched_pets = Pet.search(params[:pet_name]) if !params[:pet_name].nil?
  end

  def create
    @application = Application.new(application_params)

    if @application.save  
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: All sections must be filled out"
    end
  end

  def edit
  end

  def update
    application = Application.find(params[:id])
    if params[:freeform].length > 12
      if application.description == nil && application.status == "In Progress"
        application.update(status: params[:status], description: params[:freeform])
        redirect_to "/applications/#{application.id}"
      end
    else
      flash[:notice] = "Description must be filled out and be at least 12 characters."
      redirect_to "/applications/#{application.id}"
    end

  end

private
  def application_params
    params.permit(:applicant_name, :street_address, :city, :state, :zip_code, :description, :pet_name)
  end
end