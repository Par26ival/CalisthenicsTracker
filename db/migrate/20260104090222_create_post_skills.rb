class CreatePostSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :post_skills do |t|
      t.references :post, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_skills, [:post_id, :skill_id], unique: true
  end
end
