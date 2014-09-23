class Api::V1::CommentsController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def show
    # use submission_id to pull
    comments_json = []
    comments = Comment.where({submission_id: params[:submission_id]})
    parent_comments = comments.where({parent_id: -1}).order(comment_id: :asc)
    child_comments = comments.where.not({parent_id: -1})
    parent_comments.each do |comment|
      direct_child_comments = child_comments.where({parent_id: comment.comment_id}).order(comment_id: :asc)
      comment_hash = comment.attributes
      comment_hash["thread"] = direct_child_comments.map{|c| c.attributes}
      comment_hash["showThread"] = true
      comment_hash["threadView"] = "Hide Thread"
      comment_hash["replyThread"] = false
      comments_json << comment_hash
    end
    puts comments_json
    render json: comments_json
  end
    #pull out posts that have no parents
    #for each post, pull outs post that have this post as parent

  def create
    # author = Student.where({canvas_user_id: 1}).first
    author = Student.where({canvas_user_id: session[:canvas_user_id].to_i}).first
    if params["thread"] #It is a child comment
      comment_attributes = {
        parent_id: params["comment_id"],
        comment_id: params["thread"].length - 1, #will be unique, as it return the current number of replies (assuming no deletes)
        content: params["thread"].last["content"],
        submission_id: params["submission_id"],
        authors_canvas_id: author.canvas_user_id,
        author: author.name
      }
    else #It is a parent comment
      comment_attributes = {
        parent_id: -1, #has no parent
        comment_id: params["commentID"],
        content: params["content"],
        submission_id: params["photoID"],
        authors_canvas_id: author.canvas_user_id,
        author: author.name
      }
    end
    comment =  Comment.new comment_attributes
    gallery_comment = PointsConfiguration.where({interaction: 'GalleryComment'}).first
    if comment.save
      Activity.score! ({ reason: "GalleryComment", delta: gallery_comment.points_associated,
                         canvas_user_id: session[:canvas_user_id],
                         # canvas_user_id: 1,
                         canvas_scoring_item_id: comment.id, score: gallery_comment.active,
                         canvas_updated_at: nil, body: comment.content})
      head :ok
    else
      render :nothing => true, :status => 400
    end
  end
end

