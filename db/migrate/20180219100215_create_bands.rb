class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :bn_head
      t.string :bn_url
      t.string :bn_anonce
      t.string :bn_tema
      t.integer :bn_rang
      t.string :bn_coment

      t.timestamps null: false
    end
  end
end
