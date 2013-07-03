class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :invite, null: false, unique: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
