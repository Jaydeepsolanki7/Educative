class ProductPolicy < ApplicationPolicy
  def update?
    user.id == record.product_creator_id
  end

  def edit?
    update?
  end
end