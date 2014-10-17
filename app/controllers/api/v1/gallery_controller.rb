class Api::V1::GalleryController < ApplicationController

  # GET /api/v1/gallery/index.json
  GALLERY_UI_ATTRIBUTES = ['id','canvas_user_id','assignment_id','submission_id','attachment_id', 'author','date','content_type','url']
  def index
    images = Attachment.select(GALLERY_UI_ATTRIBUTES)
    image_json = images.to_a.map(&:serializable_hash).each{
      |k, v|
      k['id'] = "#{k['assignment_id']}-#{k['id']}"
      k['image_url'] = k['url']
      k['type'] = 'image'
    }
    puts Attachment.select(GALLERY_UI_ATTRIBUTES)

    video_json = MediaUrl.hash_for_api
    json = image_json + video_json
    render json: {'files' => json}, layout: false
  end

end
