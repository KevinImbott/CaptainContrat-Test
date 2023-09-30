# frozen_string_literal: true
class PersosController < ApplicationController
  def index
    @persos = Perso.all

    respond_to do |format|
      format.html
      format.json { render json: @persos }
    end
  end

  def create
    render json: Perso.create(perso_params)
  end

  def show
    render json: perso
  end

  def update
    perso.update!(perso_params)
    render json: perso
  end

  def destroy
    render json: perso.destroy
  end

  private

  def perso_params
    params.require(:perso).permit(:name, :health, :attack, :speed, :luck, :level, :experience)
  end

  def perso
    @perso ||= Perso.find(params[:id])
  end
end
