class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.float :quantity
      t.float :portiion_nbr
      t.float :portion_qty
      t.boolean :gluten
      t.boolean :dairy
      t.boolean :penaut
      t.boolean :seafood
      t.boolean :soy
      t.boolean :egg
      t.boolean :sesame
      t.boolean :sugar
      t.boolean :vegetarian
      t.boolean :vegan
      t.float :calories
      t.float :fat
      t.float :fat_trans
      t.float :carb
      t.float :protein
      t.float :sugarqty
      t.timestamps
    end
  end
end
