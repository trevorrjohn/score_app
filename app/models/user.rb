class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :handle, :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,     :presence       => true,
                       :length         => { :in => 4..25 }
  validates :email,    :presence       => true,
                       :format         => { :with => email_regex },
                       :uniqueness     => { :case_sensitive => false }
  validates :handle,   :presence       => true,
                       :length         => { :in => 4..12 },
                       :uniqueness     => { :case_sensitive => false }
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :in => 6..10 }

  def has_password?(submitted_password)
    submitted_password == authenticate(submitted_password)
=begin
    encrypted_password == encrypt(submitted_password)
=end
  end
end
