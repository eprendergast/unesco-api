class CreateSites < ActiveRecord::Migration[6.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.integer :category_id
      t.integer :region_id
      t.string :criteria_txt
      t.string :danger
      t.integer :date_inscribed
      t.string :extension
      t.string :http_url
      t.integer :unesco_id_number
      t.string :image_url
      t.string :justification
      t.decimal :latitude
      t.decimal :longitude
      t.string :location
      t.string :revision
      t.string :secondary_dates
      t.string :short_description
      t.boolean :transboundary
      t.integer :unique_number
      t.timestamps
    end
  end
end
