Rails.application.config.middleware.use OmniAuth::Builder do
	sns = YAML.load_file "#{Rails.root}/config/omniauth.yml"
	provider :google_oauth2, sns[:google][:key],   sns[:google][:secret],   :client_options => { :ssl => { :ca_file=>"#{Rails.root}/config/cacert.pem" }}
	provider :facebook,      sns[:facebook][:key], sns[:facebook][:secret], :client_options => { :ssl => { :ca_file=>"#{Rails.root}/config/cacert.pem" }}
	provider :twitter,       sns[:twitter][:key],  sns[:twitter][:secret]
	provider :weibo,         sns[:weibo][:key],    sns[:weibo][:secret]
#	provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
