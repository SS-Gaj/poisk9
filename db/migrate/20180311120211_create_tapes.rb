class CreateTapes < ActiveRecord::Migration
  def change
    create_table :tapes do |t|
      t.integer :tp_site
      t.datetime :tp_date
      t.string :tp_article
      t.string :tp_url
      t.integer :tp_status
      t.string :tp_tag
      t.string :tp_comments

      t.timestamps null: false
    end
  end
end
