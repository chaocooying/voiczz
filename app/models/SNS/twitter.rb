class SNS::Twitter

	public

	def self.parse data
		return {
			:provider    => data[:provider],
			:uid         => data[:uid],
#			:email       => data[:info][:email],
			:name        => data[:info][:name],
			:nickname    => data[:info][:nickname],
			:pic         => data[:info][:image],
			:url         => data[:info][:urls][:Twitter],
			:credentials => {
				:token         => data[:credentials][:token],
				:secret        => data[:credentials][:secret]
			},
			:extra => {
				:id => data[:extra][:raw_info][:id]
			}
		}
	end

end