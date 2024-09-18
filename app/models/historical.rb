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

  def recom_answer(attributes_to_display)
    version = Rails.env.development? ? "1/development" : nil
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o",
      response_format: { "type": "json_object" },
      messages: [
        {
          role: "system",
          content: "Eres un asesor de ventas online de productos alimenticios en la región de Perú, Lima"
          },
        {
        role: "user",
        content: "Necesito que me recomiendes un listado de 2 opciones de alimentos alternativos similares a #{self.product.name} y que no contengan estas restricciones: #{attributes_to_display} y dame el resultado en formato JSON con la estructura: {item_1: {product_name:, description: , brand_name: ,url_store: }, item_2: {product_name:, description: , brand_name: ,url_store: }}"
        }
      ]
    })

    #return chatgpt_response["choices"][0]["message"]["content"]
    hash = JSON.parse(chatgpt_response["choices"][0]["message"]["content"])
  end
end
