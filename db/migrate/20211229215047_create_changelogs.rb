class CreateChangelogs < ActiveRecord::Migration[6.1]
  def change
    create_table :changelogs do |t|
      t.string :payer
      t.integer :points

      t.timestamps
    end
  end
end
