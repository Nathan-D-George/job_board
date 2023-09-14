class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.integer :theme, default: 0
      t.references :user, null: false, foreign_key: true
    end
  end
end
