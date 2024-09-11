class RenamePenautToPeanutInProfiles < ActiveRecord::Migration[7.1]
  def change
    rename_column :profiles, :penaut, :peanut
  end
end
