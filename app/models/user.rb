class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :catalog_product_subscriptions, dependent: :destroy
  has_many :created_products, class_name: 'Product', foreign_key: 'product_creator_id', dependent: :destroy
end
