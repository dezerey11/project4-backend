class User < ApplicationRecord
  # a function that comes from Application Record that wraps the class. Allows methods to secure a password.
  has_secure_password
end
