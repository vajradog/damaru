class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :nav
      t.string :slug
      t.string :external_url
      t.timestamps
    end
  end
end
