class RuleController < ApplicationController

	def index
#		if current_user.authentications.size < 2
			flash[:message] = t "msg.authentication.more"
			render "authentication/empty"
#		end
	end

end
