class WeddingPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    user == record.user
  end

  def update?
    edit?
  end

  def show?
    edit? || user.registries.where(wedding: record).any?
  end

  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
