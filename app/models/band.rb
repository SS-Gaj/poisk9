class Band < ActiveRecord::Base

	validates :bn_url, presence: true, uniqueness: true

end
