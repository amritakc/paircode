class Language < ActiveRecord::Base
	has_many :ninjas, dependent: :destroy
	has_many :users, through: :ninjas
end
