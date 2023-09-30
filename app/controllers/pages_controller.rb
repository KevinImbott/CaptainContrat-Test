# frozen_string_literal: true
class PagesController < ApplicationController
    def index
        @persos = Perso.all

        respond_to do |format|
          format.html
          format.json { render json: @persos }
        end
    end
end
