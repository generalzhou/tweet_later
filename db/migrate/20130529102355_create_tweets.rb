class CreateTweets < ActiveRecord::Migration
  
  def change
    create_table :tweets do |t|
      t.references :user
      t.string :text
      t.integer :job_id
      t.timestamps
    end
  end
end
