class RemoveChatroomIdInMessages < ActiveRecord::Migration[6.1]
  def change
    remove_reference :messages, :chatroom, foreign_key: true
  end
end
