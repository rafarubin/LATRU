class Product < ApplicationRecord
  has_many :historicals
  has_many_attached :photos

  def set_product_attributes
    Rails.cache.fetch("#{cache_key_with_version}/content") do
      messages = [
        { "type": "text", "text": "Necesito que analices ambas imagenes y me devuelvas únicamente un json con los siguientes keys. En primer lugar, los keys nombre, marca y cantidad_de_porciones y porciones_por_empaque con sus respectivos valores. Luego, los keys que empiecen con 'apto' con verdadero si el producto es apto para consumo según el criterio o falso si no es apto para el consumo. Además, quiero que en los keys que los demás keys los devuelvas su valor nutricional correspondiente.

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
              "url": "https://www.ahorramas.com/dw/image/v2/BFNH_PRD/on/demandware.static/-/Sites-ahorramas-master/default/dw7c6310cc/Assets/026550_EIAh/large/a/c/c/8/acc8f7ce52b8cdc890323295ef6ee57b6e1edb92_026550_EIAh.jpg?sh=450",
          }
        },
        { "type": "image_url",
          "image_url": {
            "url": "https://www.ahorramas.com/dw/image/v2/BFNH_PRD/on/demandware.static/-/Sites-ahorramas-master/default/dw7c6310cc/Assets/026550_EIAh/large/a/c/c/8/acc8f7ce52b8cdc890323295ef6ee57b6e1edb92_026550_EIAh.jpg?sh=450",
        }
      }
      ]
      client = OpenAI::Client.new
      chatgpt_response = client.chat(parameters: {
        model: "gpt-4o",
        response_format: { type: "json_object" },
        messages: [{ role: "user", content: messages}]
      })
      chatgpt_response["choices"][0]["message"]["content"]
    end
  end
end
