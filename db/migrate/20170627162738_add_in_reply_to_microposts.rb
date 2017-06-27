class AddInReplyToMicroposts < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :reply_to, :integer
  end
end
