# frozen_string_literal: true
class PagesController < ApplicationController
  def index
    @champions = Champion.all

    respond_to do |format|
      format.html
      format.json { render json: @champions }
    end
  end
end
