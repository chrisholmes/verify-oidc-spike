class User < ApplicationRecord

  def sign_in!
    self.last_sign_in_at = DateTime.now
    save!
  end
end
