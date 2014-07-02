class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :source
      t.references :gadget

      t.timestamps
    end
  end
end
