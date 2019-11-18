class CreateSiteStates < ActiveRecord::Migration[6.0]
  def change
    create_table :site_states do |t|
      t.integer :site_id
      t.integer :state_id
      t.timestamps
    end
  end
end
