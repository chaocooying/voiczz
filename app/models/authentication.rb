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

	## Validations
	validates :provider, :presence=>true
	validates :uid,      :presence=>true
#	validates :email,    :email=>true
#	validates :pic,      :url=>true
#	validates :url,      :url=>true

	## Functions
	def self.parse omniauth, extra = nil
		data = { :provider=>omniauth[:provider], :uid=>omniauth[:uid] }
		data[:email] = omniauth[:info][:email]
		data[:name] = omniauth[:info][:name]
		data[:nickname] = omniauth[:info][:nickname]
		data[:pic] = omniauth[:info][:image]
		data[:url] = omniauth[:extra][:raw_info][:link]
		case data[:provider]
			when "google_oauth2"
	 			data[:credentials] = {
	 				:access_token => omniauth[:credentials][:token],
	 				:refresh_token => omniauth[:credentials][:refresh_token],
	 				:expires_in=> omniauth[:credentials][:expires_at]
	 			}
			# when "facebook"
			else
puts "**** #{omniauth.to_yaml}"
xxxxx
	 			data[:credentials] = {
	 				:access_token => omniauth[:credentials][:token],
	 				:refresh_token => omniauth[:credentials][:refresh_token],
	 				:expires_in=> omniauth[:credentials][:expires_at]
	 			}
	 	end
	 	data[:provider] = extra if extra == "googleplus"
		return data
	end

end
