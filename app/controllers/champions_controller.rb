# frozen_string_literal: true
class ChampionsController < ApplicationController
  def index
    @champions = Champion.all

    respond_to do |format|
      format.html
      format.json { render json: @champions }
    end
  end

  def create
    render json: Champion.create(champion_params)
  end

  def show
    render json: champion
  end

  def update
    champ.update!(champ_params)
    render json: champ
  end

  def destroy
    render json: Champ.destroy
  end

  private

  def champion_params
    params.require(:champion).permit(:name, :health, :attack, :speed, :luck, :level, :experience)
  end

  def champion
    @champion ||= Champion.find(params[:id])
  end
end
