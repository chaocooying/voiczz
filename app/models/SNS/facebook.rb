class SNS::Facebook

	public

	def self.parse data
		return {
			:provider    => data[:provider],
			:uid         => data[:uid],
			:email       => data[:info][:email],
			:name        => data[:info][:name],
			:nickname    => data[:info][:nickname],
			:pic         => data[:info][:image],
			:url         => data[:extra][:link],
			:credentials => {
				:token         => data[:credentials][:token],
				:refresh_token => data[:credentials][:refresh_token],
				:expires_in    => data[:credentials][:expires_at]
			},
			:extra => {
				:id => data[:extra][:id]
			}
		}
	end

end