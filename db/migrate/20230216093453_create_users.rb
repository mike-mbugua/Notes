class CreateUsers < ActiveRecord::Migration[7.0]
  # to create a user you might need something unique like email address
  # then use the username to login
  def change
    create_table :users do |t|
      t.string :username
      t.text :email
      t.text :password_digest

      t.timestamps
    end
  end
end
