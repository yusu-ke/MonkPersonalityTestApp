class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.text :content

      t.timestamps
    end
  end
end
