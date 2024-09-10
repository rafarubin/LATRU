class CreateHistoricals < ActiveRecord::Migration[7.1]
  def change
    create_table :historicals do |t|

      t.timestamps
    end
  end
end
