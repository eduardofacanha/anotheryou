class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|

      t.references :taken_by, references: :user
      t.references :tagged, references: :user

      t.timestamps
    end

  end
end