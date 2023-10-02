# frozen_string_literal: true
class BattlesController < ApplicationController
  def index
    @battles = Battle.all
    @battle = Battle.new
    respond_to do |format|
      format.html
  end
  end

  def create
    if battle_params[:champion_id] == battle_params[:opponent_id]
      render json: { error: 'Champion and opponent must be different' }, status: :bad_request
      return
    end

    @battle = Battle.new(champion: champion, opponent: opponent)
    @battle.save

    respond_to do |format|
        format.html
        format.json { render json: @battle }
        redirect_to @battle
    end
  end

  def show
    @battle = battle
    respond_to do |format|
      format.html
    end
  end

  private

  def battle_params
    params.require(:battle).permit(:champion_id, :opponent_id)
  end

  def battle
    @battle ||= Battle.find(params[:id])
  end

  def champion
    @champion ||= Champion.find(battle_params[:champion_id])
  end

  def opponent
    @opponent ||= Champion.find(battle_params[:opponent_id])
  end
end
