class CreateEnlistments < ActiveRecord::Migration[7.0]
  def change
    create_table :enlistments do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.date :enlistment_date
    end
  end
end
