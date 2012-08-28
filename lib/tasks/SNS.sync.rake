task :sync => :environment do

	data = [
		# Feed
		{
			:user => {
				:provider => :googleplus,
				:email => "ying@stillnaughty.com"
			},
			:from => {
				:user_id => 1,
				:provider => :googleplus,
				:email => "ying@stillnaughty.com",
				:type => "feed",
				:scope => "public"
			},
			:to => [
				{ :provider=>:facebook, :email=>"ying@stillnaughty.com", :scope=>"public" },
				{ :provider=>:twitter, :email=>"about@stillnaughty.com" },
				{ :provider=>:twitter, :email=>"ying@stillnaughty.com" },
				{ :provider=>:weibo, :email=>"aeneas.ying@gmail.com" },
				{ :provider=>:weibo, :email=>"me@stillnaughty.com" },
				{ :provider=>:douban, :email=>"ying@stillnaughty.com", :scope=>"public" },
				{ :provider=>:kaixin, :email=>"ying@stillnaughty.com", :scope=>"public" },
				{ :provider=>:linkedin, :email=>"about@stillnaughty.com" },
				{ :provider=>:tumblr, :email=>"site@stillnaughty.com", :url=>"life.stillnaughty.com" },
				{ :provider=>:weibo, :email=>"bad.ryan@msn.com" },
				{ :provider=>:qzone, :email=>"bad.ryan@msn.com" }
			]
		}
		# Blog      blog.stillnaughty >>> bitly >>> google+ >>> facebook, twitter, weibo, douban, kaixin, linkedin
		# Life      google+ >>> facebook, twitter, weibo, tumblr, douban, kaixin, qzone
		# Interest  Pinterest, Douban
		# Photo     Pinterest, Douban, Flickr, Picasa
		# Music     Douban
		# Video     Youtube, Vimeo, Youku, Todou, Ku6
		# PPT
	]

	data.each do |rule|

		puts "=== Start Rule ================================================================="

		user = User.find_by :provider=>rule[:user][:provider], :email=>rule[:user][:email]
		puts "\n/// 1. User ...................................................................."
		puts user.to_yaml

		sns = SNS.new user
		data = sns.get rule[:from]
		puts "\n/// 2. From ...................................................................."
		puts data.to_yaml

		rule[:to].each do |service|
			sns.sync service, data
			puts "\n/// 3. To ......................................................................"
			puts service.to_yaml
		end

	end
	puts "=== END ========================================================================"

end

# task :dummy => [:greet, :greet2] do
# 	puts "How are you?"
# end
