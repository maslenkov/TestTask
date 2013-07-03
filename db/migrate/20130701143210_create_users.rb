class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :name, null: false
      t.string :password_digest
      t.string :phone

      t.timestamps
    end
  end
end
