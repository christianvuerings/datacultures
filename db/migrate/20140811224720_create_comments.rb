class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer     :parent_id,          null: false #comment_id of parent comment, or nil if no parent exists
      t.integer     :comment_id,         null: false #A number representing the n'th comment submitted so far under a specific submission. It should be unique if there is no deletions
      t.text        :content
      t.integer     :submission_id,      null: false
      t.integer     :authors_canvas_id,  null: false
      t.string      :author
      t.timestamps
    end
  end
end
