# Notice the namespacing for our controller, this namespacing convention is extremely important to follow
# Remember we version because we anticipate change, to honor the contract we make with our users, and to keep version control
# Remember all controllers related to the api will exist in this folder
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
