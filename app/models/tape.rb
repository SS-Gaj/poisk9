class Tape < ActiveRecord::Base
	default_scope -> { order('tp_date DESC') }
  validates :tp_article, presence: true
	validates :tp_url, presence: true, uniqueness: true
end
