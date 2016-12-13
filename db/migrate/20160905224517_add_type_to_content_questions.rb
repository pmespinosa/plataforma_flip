class AddTypeToContentQuestions < ActiveRecord::Migration
  def change
    add_column :content_questions, :type, :string
  end
end
