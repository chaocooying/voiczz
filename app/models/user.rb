class User

	include Mongoid::Document

	## Relations
	has_many :authentications, :inverse_of => :user, :autosave => true

	# Include default devise modules. Others available are:
	# :validatable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :rememberable, :trackable

	## Database authenticatable
	field :email,              :type => String, :default => ""
	field :encrypted_password, :type => String, :default => ""
	field :name,               :type => String
	field :pic,                :type => String
	field :provider,           :type => String
	field :uid,                :type => String

	## Recoverable
	field :reset_password_token,   :type => String
	field :reset_password_sent_at, :type => Time

	## Rememberable
	field :remember_created_at, :type => Time

	## Trackable
	field :sign_in_count,      :type => Integer, :default => 0
	field :current_sign_in_at, :type => Time
	field :last_sign_in_at,    :type => Time
	field :current_sign_in_ip, :type => String
	field :last_sign_in_ip,    :type => String

	## Confirmable
	# field :confirmation_token,   :type => String
	# field :confirmed_at,         :type => Time
	# field :confirmation_sent_at, :type => Time
	# field :unconfirmed_email,    :type => String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
	# field :locked_at,       :type => Time

	## Token authenticatable
	field :authentication_token, :type => String

	## Validation
	validates :email,              :presence=>true
	validates :encrypted_password, :presence=>true

	## Custom Validation (Copy from Devise)
#	validates_presence_of     :email,    :if=>:email_required?
# 	validates_uniqueness_of   :email,    :case_sensitive=>false, :allow_blank=>true, :if=>:email_changed?
	validates_format_of       :email,    :with =>Devise.email_regexp, :allow_blank=>true, :if=>:email_changed?
#	validates_presence_of     :password, :if=>:password_required? # :on=>:create
	validates_confirmation_of :password, :on=>:create
	validates_length_of       :password, :within=>Devise.password_length, :allow_blank=>true

end
