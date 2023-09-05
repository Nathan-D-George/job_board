class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :qualification
      t.integer :level
      t.integer :institution
      t.date :start_date
      t.date :end_date

    end
  end
end
