class AddReferencesToHistoricals < ActiveRecord::Migration[7.1]
  def change
    add_reference :historicals, :profile, null: false, foreign_key: true
    add_reference :historicals, :product, null: false, foreign_key: true
  end
end
