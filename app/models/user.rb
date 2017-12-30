class User < ApplicationRecord
  enum status: {
    "Administrator" => 1,
    "Staff" => 2,
    "User" => 3
  }

  validates :name, presence: true, uniqueness: true
  validates :status, inclusion: statuses.keys
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end 
end
