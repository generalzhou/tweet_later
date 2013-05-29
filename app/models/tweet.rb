class Tweet < ActiveRecord::Base

  belongs_to :user
  validates_length_of :text, :maximum=>141

end
