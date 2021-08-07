class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title,null: false
      t.string :year,null: false
      t.boolean :live,null: false,default: false
      t.integer :band_id,null: false

      t.timestamps
    end
    add_index :albums,:band_id
  end
end
