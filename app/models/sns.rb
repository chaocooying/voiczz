class SNS

 	attr_accessor :user

 	public

	def initialize user
		@user = user
	end

	def get service
		sns = @user.authentications.find_by :provider=>service[:provider], :email=>service[:email]
		api = load sns
		return api.recent
	end

	def sync service, data
# 		@twitter.update
	end

	private

	def load sns
		return case sns.provider
			when "googleplus" then SNS::GooglePlus.new sns
		end
	end

end
