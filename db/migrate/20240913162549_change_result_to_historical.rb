class ChangeResultToHistorical < ActiveRecord::Migration[7.1]
  def change
    change_column :historicals, :results, 'boolean USING CAST(results AS boolean)'
  end
end
