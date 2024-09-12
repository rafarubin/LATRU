class ChangeBarcodenumToString < ActiveRecord::Migration[7.1]
  def change
    change_column :barcodes, :barcode_num, :string
  end
end
