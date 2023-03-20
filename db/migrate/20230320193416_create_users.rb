class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :login
      t.string :phone, index: { unique: true }
      t.string :password_digest
      t.boolean :email_confirmed, default: false
      t.string :confirm_token
      t.timestamps
    end
  end
end
