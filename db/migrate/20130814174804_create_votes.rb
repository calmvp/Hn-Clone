class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :up
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
