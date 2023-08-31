class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string  :name
      t.text    :description
      t.integer :location, default: 0
      t.integer :number_employees, default: 2
      t.string  :website, default: 'https://www.example.com'
      t.references :user, null: false, foreign_key: true

    end
  end
end
