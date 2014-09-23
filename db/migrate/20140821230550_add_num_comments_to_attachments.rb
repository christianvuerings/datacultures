class AddNumCommentsToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :num_comments, :integer
  end
end
