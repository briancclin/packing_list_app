# frozen_string_literal: true

class TransportationsController < ApplicationController
  before_action :set_transportation, only: %i[show edit update destroy]

  # GET /transportations
  # GET /transportations.json
  def index
    @transportations = Transportation.all
  end

  # GET /transportations/1
  # GET /transportations/1.json
  def show; end

  # GET /transportations/new
  def new
    @transportation = Transportation.new
  end

  # GET /transportations/1/edit
  def edit; end

  # POST /transportations
  # POST /transportations.json
  def create
    @transportation = Transportation.new(transportation_params)

    respond_to do |format|
      if @transportation.save
        format.html do
          redirect_to @transportation, notice: 'Transportation was successfully created.'
        end
        format.json { render :show, status: :created, location: @transportation }
      else
        format.html { render :new }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportations/1
  # PATCH/PUT /transportations/1.json
  def update
    respond_to do |format|
      if @transportation.update(transportation_params)
        format.html do
          redirect_to @transportation, notice: 'Transportation was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @transportation }
      else
        format.html { render :edit }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportations/1
  # DELETE /transportations/1.json
  def destroy
    @transportation.destroy
    respond_to do |format|
      format.html do
        redirect_to transportations_url, notice: 'Transportation was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transportation
    @transportation = Transportation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transportation_params
    params.require(:transportation).permit(:transportation)
  end
end
