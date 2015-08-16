class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :display_name
      t.string :password_digest
      t.string :role
      t.string :slug
      t.timestamps
    end
  end
end
