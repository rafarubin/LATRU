class CreateBarcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :barcodes do |t|
      t.integer :barcode_num

      t.timestamps
    end
  end
end
