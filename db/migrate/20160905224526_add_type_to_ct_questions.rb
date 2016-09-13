class AddTypeToCtQuestions < ActiveRecord::Migration
  def change
    add_column :ct_questions, :type, :string
  end
end
