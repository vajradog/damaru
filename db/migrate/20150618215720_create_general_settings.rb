class CreateGeneralSettings < ActiveRecord::Migration
  def change
    create_table :general_settings do |t|
      t.string :title
      t.string :header
      t.string :subheader
      t.string :template
      t.timestamps
    end
  end
end
