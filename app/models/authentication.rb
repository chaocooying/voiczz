class Authentication

	include Mongoid::Document

	## Relations
	belongs_to :user, :inverse_of => :authentications

	## Fields
	field :provider, :type => String
	field :uid,      :type => String
	field :email,    :type => String
	field :name,     :type => String
	field :nickname, :type => String
	field :pic,      :type => String
	field :url,      :type => String

	## Validations
	validates :provider, :presence=>true
	validates :uid,      :presence=>true
#	validates :email,    :email=>true
#	validates :pic,      :url=>true
#	validates :url,      :url=>true

	## Functions
	def self.parse auth
		data = { :provider=>auth[:provider], :uid=>auth[:uid] }
		case data[:provider]
			when "facebook", "google_oauth2"
				data[:email] = auth[:info][:email]
	 			data[:name] = auth[:info][:name]
	 			data[:nickname] = auth[:info][:nickname]
	 			data[:pic] = auth[:info][:image]
	 			data[:url] = auth[:extra][:raw_info][:link]
	 	end
		return data
	end

end
