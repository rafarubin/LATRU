class Historical < ApplicationRecord
  belongs_to :profile
  belongs_to :product

  def calculate_result
    attributes = %w[gluten peanut seafood soy egg sesame sugar vegetarian vegan dairy]

    attributes.each do |attribute|
      product_value = product.send(attribute)
      profile_value = profile.send(attribute)

      if product_value == false && profile_value == true
        results = "Producto no es apto para que lo consumas"
        self.update(results: results)
        return
      end
    end

    results = "Producto sí es apto para que lo consumas"
    self.update(results: results)
  end
end
