class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :password, :password_confirmation
  has_secure_password

  before_save do |user|
    user.email = email.downcase
    if user.phone.blank?
      user.phone = nil
    else
      unless user.phone =~ /\A\+/
        user.phone = '+' + user.phone
      end
    end
  end

  validates_presence_of :name

  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}, presence: true
  validates :phone, format: {with: /\A\+?\d{11,12}\z/}, allow_blank: true
  validates :password, :password_confirmation, presence: true, length: {minimum: 6}, :unless => lambda{ |user| user.password.blank? }, on: :update
  validates :password, :password_confirmation, presence: true, length: {minimum: 6}, on: :create

  after_validation {self.errors.messages.delete(:password_digest)}
end
