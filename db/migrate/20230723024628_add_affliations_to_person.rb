class AddAffliationsToPerson < ActiveRecord::Migration[5.1]
  def change
    add_reference :affilations, :person, foreign_key: true
  end
end
