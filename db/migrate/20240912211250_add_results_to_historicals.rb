class AddResultsToHistoricals < ActiveRecord::Migration[7.1]
  def change
    add_column :historicals, :results, :string
  end
end
