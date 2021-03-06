require 'securerandom'

class User < ApplicationRecord

before_create :set_access_token

# ------------------------------------------------------------------------------
# Includes & Extensions
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Attributes
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Associations
# ------------------------------------------------------------------------------

has_many :events, through: :guests
has_many :guests, dependent: :destroy
has_many :messages


# ------------------------------------------------------------------------------
# Validations
# ------------------------------------------------------------------------------

validates_uniqueness_of :email, :facebook_id

# ------------------------------------------------------------------------------
# Callbacks
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Nested Attributes
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Scopes
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Other
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# Class Methods
# ------------------------------------------------------------------------------

def self.koala(auth)
	facebook_auth_token = auth['facebook_auth_token']
	@graph = Koala::Facebook::API.new(facebook_auth_token)
	profile = @graph.get_object("me?fields=email,name,picture.type(large)")
	return profile
end

def update_details(profile, user_params)
	auth = user_params['facebook_auth_token']
	self.facebook_auth_token = auth
	self.facebook_id =  profile['id']
	self.name = profile['name']
	self.facebook_picture =  profile['picture']['data']['url']
	self.email = profile['email']
end

# ------------------------------------------------------------------------------
# Instance Methods
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
protected
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
private
# ------------------------------------------------------------------------------


  def set_access_token
    return if access_token.present?
    self.access_token = generate_access_token
  end

  def generate_access_token
    SecureRandom.uuid.gsub(/\-/,'')
  end




end
