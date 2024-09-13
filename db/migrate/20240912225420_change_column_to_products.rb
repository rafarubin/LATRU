class ChangeColumnToProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :penaut, :peanut
  end
end
