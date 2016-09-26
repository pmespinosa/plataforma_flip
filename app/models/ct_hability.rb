class CtHability < ActiveRecord::Base
	has_many :ct_subhabilities
	has_and_belongs_to_many :ct_questions
end
