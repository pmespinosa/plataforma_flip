class CreateJoinTableCtHabilityCtQuestion < ActiveRecord::Migration
  def change
    create_join_table :ct_habilities, :ct_questions do |t|
      # t.index [:ct_hability_id, :ct_question_id]
      # t.index [:ct_question_id, :ct_hability_id]
    end
  end
end
