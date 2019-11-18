class CreateSiteIsoCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :site_iso_codes do |t|
      t.integer :site_id 
      t.integer :iso_code_id
      t.timestamps
    end
  end
end
