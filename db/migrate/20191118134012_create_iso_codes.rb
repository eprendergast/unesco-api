class CreateIsoCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :iso_codes do |t|
      t.string :alpha_2_code
      t.timestamps
    end
  end
end
