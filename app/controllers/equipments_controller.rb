# frozen_string_literal: true
class EquipmentsController < ApplicationController
    def index
      @equipments = Equipment.all

      render json: @equipments
    end
  
    def show
      render json: equipment
    end
  
    def destroy
      render json: equipment.destroy
    end
  
    private
  
    def equipment
      @equipment ||= Equipment.find(params[:id])
    end
  end
  