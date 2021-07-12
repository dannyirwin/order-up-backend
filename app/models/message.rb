class Message < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def message_data
    {content: content,
    created_at: created_at,
    username: user.username
}
  end
end
