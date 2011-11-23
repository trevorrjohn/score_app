class User < ActiveRecord::Base
  has_many :scores

  attr_accessible :name, :email, :handle, :password, :password_confirmation
  has_secure_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,     :presence       => true,
                       :length         => { :in => 4..25 }
  validates :email,    :presence       => true,
                       :format         => { :with => email_regex },
                       :uniqueness     => { :case_sensitive => false }
  validates :handle,   :presence       => true,
                       :length         => { :in => 4..25 },
                       :uniqueness     => { :case_sensitive => false }
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :in => 6..10 }

  before_save :encrypt_password

  def has_password?(submitted_password)
    submitted_password == authenticate(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

  def encrypt_password
    self.salt = make_salt unless has_password?(password)
  end

  def make_salt
    secure_hash("#{salt}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
