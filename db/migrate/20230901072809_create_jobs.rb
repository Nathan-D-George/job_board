class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string  :name
      t.text    :description
      t.integer :required_experience, default: 1
      t.integer :salary, default: 10000
      t.references :company, null: false, foreign_key: true

    end
  end
end
