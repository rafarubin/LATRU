require "openai"
require "json"


class Product < ApplicationRecord
  has_many :historicals
  has_many_attached :photos

  def set_product_attributes
    Rails.cache.fetch("#{cache_key_with_version}/content") do
      version = "1/development"

      messages = [
        { "type": "text", "text": "Necesito que analices ambas imagenes y me devuelvas únicamente un json con los siguientes keys. En primer lugar, extrae de la imagen el nombre, marca y cantidad_de_porciones y porciones_por_empaque y colócalos en su respectiva key. Luego, los keys que empiecen con 'apto' con verdadero si el producto es apto para consumo según el criterio o falso si no es apto para el consumo. Además, quiero los demás keys los devuelvas su cantidad nutricional correspondiente.
        nombre:
        marca:
        cantidad:
        porciones_por_empaque:
        apto_gluten_free:
        apto_alergia_mani:
        apto_alergia_mariscos:
        apto_alergia_soya:
        apto_alergia_huevos:
        apto_alergia_ajonjoli:
        apto_intolertante_lactosa:
        apto_cero_azucar:
        apto_vegetariano:
        apto_vegano:
        calorias:
        grasas:
        grasas_trans:
        carbohidratos:
        proteinas:
        azucar:

        "},
        { "type": "image_url",
            "image_url": {
              "url": Cloudinary::Utils.cloudinary_url(photos[0].key, version: version),
              "detail": "high"
          }
        },
        { "type": "image_url",
          "image_url": {
            "url": Cloudinary::Utils.cloudinary_url(photos[1].key, version: version),
            "detail": "high"
        },
        }
      ]

      client = OpenAI::Client.new

      chat_response = client.chat(
        parameters: {
          model: "gpt-4o", # Required.
          response_format: { "type": "json_object" },
          messages: [{ role: "user", content: messages }] # Required.
          })

      hash = JSON.parse(chat_response["choices"][0]["message"]["content"])

      self.update(
      name: hash["nombre"],
      brand: hash["marca"],
      quantity: hash["cantidad"],
      portion_qty: hash["porciones_por_empaque"],
      gluten: hash["apto_gluten_free"],
      dairy: hash["apto_intolertante_lactosa"],
      penaut: hash["apto_alergia_mani"],
      seafood: hash["apto_alergia_mariscos"],
      soy: hash["apto_alergia_soya"],
      egg: hash["apto_alergia_huevos"],
      sesame: hash["apto_alergia_ajonjoli"],
      sugar: hash["apto_cero_azucar"],
      vegetarian: hash["apto_vegetariano"],
      vegan: hash["apto_vegano"],
      calories: hash["calorias"],
      fat: hash["grasas"],
      fat_trans: hash["grasas_trans"],
      carb: hash["carbohidratos"],
      protein: hash["proteinas"],
      sugarqty: hash["azucar"]
      )
    end
  end
end
