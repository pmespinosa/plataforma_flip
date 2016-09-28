class AddCtQuestionToCtHabilities < ActiveRecord::Migration
  def change
    add_reference :ct_habilities, :ct_question, index: true, foreign_key: true
  end
end
