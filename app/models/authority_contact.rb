class AuthorityContact < ApplicationRecord

  validates :display_name, :phone, :email, :presence => true
  validates :phone, numericality: { only_integer: true }
  validates_length_of :phone, :minimum => 10, :maximum => 12
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})\Z/i }

end
