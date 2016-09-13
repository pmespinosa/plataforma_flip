class ChangeColumnTextInFeedbacks < ActiveRecord::Migration
  def change
  	change_column :feedbacks, :text, :text
  end
end
