class Api::V1::BaseController < ActionController::API
  # Remember we need Pundit here to protect our API Endpoints
  include Pundit

  # Standard protections after actions for pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # With APIs we need to return json when we encounter errors instead of html, these are here to do that
  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  # Helper methods to help us deal with Pundit and Active Record Exceptions
  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
