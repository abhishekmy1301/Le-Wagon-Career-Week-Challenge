class CreateMuseums < ActiveRecord::Migration[7.0]
  def change
    create_table :museums do |t|
      t.string :name
      t.string :postcode
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
