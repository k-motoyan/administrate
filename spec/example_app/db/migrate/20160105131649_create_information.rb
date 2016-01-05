class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
