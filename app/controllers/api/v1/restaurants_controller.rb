# Note the namespacing
class Api::V1::RestaurantsController < Api::V1::BaseController
  # Makes sure the controller authenticates through the token for certain actions
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  before_action :set_restaurant, except: [:index, :create]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show; end

  # Both the update and create are extremely similar to what we've seen before
  # The only difference is the status associated with the return
  # Remember these are the different HTTP requests

  # HTTP Requests you Could know
    # 2XX OK
    # 3XX Redirect
    # 4XX You fucked up
    # 5XX We fucked up (server) (THING YOU SHOULD FEAR THE MOST)

  # The other major different is the render_error, instead of rendering the same html page again as we did in a regular controller, for our api controller we render json that convey our errors
  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant

    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    # This is standard convention to return no content when the destroy action was implemented successfully
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
    # Of if you really want to be tricky do something like
    # render json: { message: "It worked! you deleted the restaurant" }
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant  # For Pundit
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
