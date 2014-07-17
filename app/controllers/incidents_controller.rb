class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  def index
    @incidents = Incident.all
      respond_to do |format|
        format.html{          }
        format.xml {
          render text: @incidents.to_xml(root:"data")
          }
      end
  end

  def news
    @incidents = Incident.where("updated_at < ?", Time.now.yesterday)
     # render xml: @incident
  end

  def show
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.html {
          render partial: "show", locals: {incident: @incident}
      }
      format.xml {
        render xml: @incident.to_xml(only:[:latitude, :longitude, :title, :description], root: "data" )
      }

      format.js {
      }

    end
  end

  def new
    @incident = Incident.new
    respond_to do |format|
      format.html {
          @incident.latitude = params[:latitude].to_f
          @incident.longitude = params[:longitude].to_f
          render partial: "new", locals: { incident: @incident}
      }
      format.xml {
        render xml: @incident.to_xml(only:[:latitude, :longitude, :title, :description], root: "data" )
      }
    end
  end

  def edit
    @incident=Incident.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        flash[:notice] = "Incident was successfully created."
        format.js { }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @incident.update(incident_params)
        flash[:notice] = "Incident was successfully updated."
        format.html { redirect_to @incident  }
        format.json { render :show, status: :ok, location: @incident }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:mountain, :latitude, :longitude, :when, :title, :description)
    end
end
