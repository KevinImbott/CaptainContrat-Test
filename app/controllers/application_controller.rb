# frozen_string_literal: true
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include ActiveStorage::SetCurrent

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
