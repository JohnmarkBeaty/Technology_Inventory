class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @attr = AttrDevice.search(@person.name).order("created_at DESC")
    @devices = Array.new
    @attr.each do |attr|
      @devices << attr.device
    end
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
        format.js { 
          @people = Person.all
          render :create 
        }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js { 
          @people = Person.all
          render :create 
        }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
        format.js {
          @people = Person.all
          render :update
        }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js {
          @people = Person.all
          render :update
        }
      end
    end
  end


  def delete
    @person = Person.find(params[:person_id])
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
      format.js {
        @people = Person.all
        render :destroy
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :extension, :direct_dial, :cell, :email)
    end
end
