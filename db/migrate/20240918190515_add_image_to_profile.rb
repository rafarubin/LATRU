class AddImageToProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :image, :string
  end
end
