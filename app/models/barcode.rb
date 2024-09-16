class Barcode < ApplicationRecord
  has_one_attached :photo

  def barcode_scan
    # version = "1/development"
    version = Rails.env.development? ? "1/development" : nil
    client = OpenAI::Client.new
    puts "URL DE IMAGEN EN CLD"
    puts Cloudinary::Utils.cloudinary_url(photo.key, version: version)
    puts "URL DE IMAGEN EN CLD"
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o",
      messages: [{ role: "user", content: [
      # {"type": "text", "text": "Necesito que me analices esta imgen y que me des la siguiente información en un formato de hash: nombre del producto, marca, contenido del producto"},
      {"type": "text", "text": "Necesito que me analices esta imgen y que me des el codigo de barras de 13 digitos en formato EAN, solo quiero el numero de barcode en formato numero, la respuesta no puede tener caracteres de letras ni simbolos, debe de tener 13 digitos, no ignores el digito inicial que está al inicio, dame como response el solo el código (integer)"},

      {
     "type": "image_url",
      "image_url": {
      "url": Cloudinary::Utils.cloudinary_url(photo.key, version: version),
      }}
      ]
      }]

     })

    return chatgpt_response["choices"][0]["message"]["content"]
  end

  def product_exists?
    prod = Product.find_by(barcode: self.barcode_num)
    if prod
      prod.id
    else
      false
    end
  end

end
