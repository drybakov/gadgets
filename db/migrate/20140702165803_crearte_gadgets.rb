class CrearteGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :name, null: false
      t.string :description
      t.references :user

      t.timestamps
    end
  end
end
