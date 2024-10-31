class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def view_avo_authored? = true
  def act_on? = true
  def impersonate? = true

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end