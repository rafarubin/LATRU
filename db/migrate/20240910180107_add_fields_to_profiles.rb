class AddFieldsToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :username, :string
    add_column :profiles, :gluten, :boolean
    add_column :profiles, :dairy, :boolean
    add_column :profiles, :penaut, :boolean
    add_column :profiles, :seafood, :boolean
    add_column :profiles, :soy, :boolean
    add_column :profiles, :egg, :boolean
    add_column :profiles, :sesame, :boolean
    add_column :profiles, :sugar, :boolean
    add_column :profiles, :vegetarian, :boolean
    add_column :profiles, :vegan, :boolean
  end
end
