class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.references :user, foreign_key: true, null: false
      t.references :shortened_url, foreign_key: true, null: false

      t.timestamps
    end
  end
end
