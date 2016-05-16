class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :stripe_charge_id
      t.boolean :refunded, default: false
      t.integer :amount
      t.boolean :paid, default: true

      t.timestamps null: false
    end
  end
end
