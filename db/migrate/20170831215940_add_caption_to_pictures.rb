class AddCaptionToPictures < ActiveRecord::Migration[5.1]
  def change
    #enable_extension 'uuid-ossp'

    add_column :pictures, :caption, :string
    add_column :pictures, :uuid, :uuid

    add_index :pictures, :uuid, unique: true
  end
end
