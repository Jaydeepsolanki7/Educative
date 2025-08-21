class Product < ApplicationRecord
  has_one_attached :image
  has_many :courses
  has_many :assessments
  belongs_to :product_creator, class_name: 'User'

  after_create :create_catalog_entry_and_class

  private

  def create_catalog_entry_and_class
    sanitized_name = name.gsub(/[^0-9a-z ]/i, '').strip # Remove special chars
    sanitized_name = "Product#{sanitized_name}" if sanitized_name =~ /^\d/
    class_name = "#{sanitized_name.delete(' ')}CatalogProductSubscription"
  
    parent_class = "CatalogProductSubscription"
    file_path = Rails.root.join("app", "models", "#{class_name.underscore}.rb")
  
    unless File.exist?(file_path)
      File.open(file_path, "w") do |file|
        file.puts "class #{class_name} < #{parent_class}"
        file.puts "end"
      end
    end
  
    load file_path
  
    CatalogProductSubscription.create!(
      type: class_name,
      product: self,
      slug: name.parameterize,
      cost: cost,
      user_id: product_creator.id
    )
  end
  
end
