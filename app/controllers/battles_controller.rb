# frozen_string_literal: true
class BattlesController < ApplicationController
  def index
    @battles = Battle.all
    render json: @battles
  end

  def create
    @battle = Battle.new(battle_params)
    @battle.save
    @battle.fight!
    
    render json: @battle.recap
    # redirect_to battle_path(@battle)
  end

  def show
    render json: battle
  end

  private

  def battle_params
    params.require(:battle).permit(:champion_id, :opponent_id)
  end

  def battle
    @battle ||= Battle.find(params[:id])
  end
end
