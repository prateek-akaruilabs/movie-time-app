class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :payment_id
      t.string :payment_type
      t.string :payment_provider
      t.decimal :payment_amount
      t.string :payment_status
      t.text :description
      t.text :failure_reason
      t.datetime :failed_at
      t.datetime :paid_at
      t.references :booking, null: false, foreign_key: true
      t.timestamps
    end
  end
end
