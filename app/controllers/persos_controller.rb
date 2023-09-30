class PersosController < ApplicationController
  def index
    render json: Perso.all
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
