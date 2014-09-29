class Api::V1::CommentsController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def create
    if params["thread"] #It is a child comment
      comment_attributes = {
        parent_id: params["commentID"],
        comment_id: params["thread"].length, #will be unique, as it return the current number of replies (assuming no deletes)
        content: params["thread"].last["content"],
        submission_id: params["photoID"],
        authors_canvas_id: current_user.canvas_id
      }
    else #It is a parent comment
      comment_attributes = {
        parent_id: -1, #has no parent
        comment_id: params["commentID"],
        content: params["content"],
        submission_id: params["photoID"],
        authors_canvas_id: current_user.canvas_id
      }
    end
    comment =  Comment.new comment_attributes
    gallery_comment = PointsConfiguration.where({interaction: 'GalleryComment'}).first
    if comment.save
      Activity.score! ({ reason: "GalleryComment", delta: gallery_comment.points_associated,
                         canvas_user_id: current_user.canvas_id,
                         canvas_scoring_item_id: comment.id, score: gallery_comment.active,
                         canvas_updated_at: nil, body: comment.content})
      head :ok
    else
      render :nothing => true, :status => 400
    end
  end
end

