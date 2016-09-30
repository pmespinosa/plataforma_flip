class RemoveCtQuestionToCtHability < ActiveRecord::Migration
  def change
    remove_reference :ct_habilities, :ct_question, index: true, foreign_key: true
  end
end
