class Api::V1::GalleryController < ApplicationController

  require 'array_refinement'
  using ArrayRefinement

  # GET /api/v1/gallery/index.json
  IMAGE_ATTRIBUTES = ['id','canvas_user_id','assignment_id','submission_id','attachment_id', 'author','date','content_type','image_url']
  VIDEO_ATTRIBUTES = ['id', 'created_at', 'site_tag', 'site_id', 'canvas_user_id', 'canvas_assignment_id', 'author']
  def index
    image_json = Attachment.select(IMAGE_ATTRIBUTES).to_a.image_hash
    video_json = MediaUrl.select(VIDEO_ATTRIBUTES).to_a.video_hash
    json = image_json + video_json
    render json: {'files' => json}, layout: false
  end

end
