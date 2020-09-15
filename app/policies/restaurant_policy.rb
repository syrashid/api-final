class RestaurantPolicy < ApplicationPolicy
  # Note all the different policy actions we have here, it is important to ask ourselves exactly who we should give access to each one of our endpoints and protect accordingly
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    # Does the restaurant creator match the token of the user submitting the api call
    record.user == user
  end

  def create?
    # Does the user exist in the db?
    !user.nil?
  end

  def destroy?
    # If I can update it, I should be able to destroy it
    update?
  end
end
