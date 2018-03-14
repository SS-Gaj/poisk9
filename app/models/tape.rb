class Tape < ActiveRecord::Base

  validates :tp_article, presence: true
	validates :tp_url, presence: true, uniqueness: true
end
