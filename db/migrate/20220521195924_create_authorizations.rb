class CreateAuthorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at
      t.string :token
      t.string :refresh_token
      t.string :provider
      t.string :name
      t.string :email
      t.string :image_url
      t.string :uid

      t.timestamps
    end
  end
end
