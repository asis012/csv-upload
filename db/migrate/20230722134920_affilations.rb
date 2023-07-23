class Affilations < ActiveRecord::Migration[5.1]
  def change
    create_table :affilations do |t|
      t.string "name"
    end
  end
end
