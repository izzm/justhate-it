class CreateHates < ActiveRecord::Migration
  def self.up
    create_table :hates do |t|
      t.references :user
      t.references :subject
      t.string :because
      t.timestamps
    end
  end

  def self.down
    drop_table :hates
  end
end
