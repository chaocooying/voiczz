class Authentication

	include Mongoid::Document

	## Relations
	belongs_to :user, :inverse_of => :authentications

	## Fields
	field :provider,    :type => String
	field :uid,         :type => String
	field :email,       :type => String
	field :name,        :type => String
	field :nickname,    :type => String
	field :pic,         :type => String
	field :url,         :type => String
	field :credentials, :type => Object
	field :extra,       :type => Object

	## Validations
	validates :provider, :presence=>true
	validates :uid,      :presence=>true
#	validates :email,    :email=>true
#	validates :pic,      :url=>true
#	validates :url,      :url=>true

	## Functions
	def self.parse omniauth, extra = nil
		case extra
			when "googleplus" then omniauth[:provider] = "googleplus"
		end
		case omniauth[:provider]
			when "googleplus" then return SNS::GooglePlus.parse omniauth
			when "facebook"   then return SNS::Facebook.parse omniauth
			when "twitter"    then return SNS::Twitter.parse omniauth
			else 
				puts "**** #{omniauth.to_yaml}"
				xxxxxx
		end
	end

end
