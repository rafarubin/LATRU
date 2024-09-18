class Historical < ApplicationRecord
  belongs_to :profile
  belongs_to :product

  include PgSearch::Model
  pg_search_scope :search_by_product_name_and_brand,
    associated_against: {
      product: [ :name, :brand ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def calculate_result
    attributes = %w[gluten peanut seafood soy egg sesame sugar vegetarian vegan dairy]

    attributes.each do |attribute|
      product_value = product.send(attribute)
      profile_value = profile.send(attribute)

      if product_value == false && profile_value == true
        # "Producto no es apto para que lo consumas"
        results = false
        self.update(results: results)
        return
      end
    end

    # "Producto sí es apto para que lo consumas"
    results = true
    self.update(results: results)
  end
end
