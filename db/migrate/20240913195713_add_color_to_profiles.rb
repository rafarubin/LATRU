class AddColorToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :color, :string
  end
end
