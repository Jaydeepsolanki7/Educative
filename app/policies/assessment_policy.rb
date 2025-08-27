class AssessmentPolicy < ApplicationPolicy
  def create?
    return false unless user.present?

    if record.product_id.present?
      product = Product.find(record.product_id)
      product.product_creator == user
    else
      false
    end
  end

  def new?
    create?
  end
end
