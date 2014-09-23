class Canvas::SubmissionsProcessor

  attr_accessor  :submission_conf, :request_object

  def initialize(conf)
    @submission_conf = PointsConfiguration.where({interaction: 'Submission'}).first
    @request_object     = conf[:request_object] || Canvas::ApiRequest.new({api_key: conf['api_key'], base_url: conf['base_url']})
  end

  def call(submissions)

    ## rewrite for return data from assignments API call
    scoring_submissions = Activity.where({reason: 'Submission'}).select(:canvas_scoring_item_id, :canvas_user_id)
    if scoring_submissions
      scored_submissions = scoring_submissions.map{|s| [s.canvas_scoring_item_id, s.canvas_user_id] }
    else
      scored_submissions = []
    end

    smap =  Student.get_students_by_id

    # TODO: move back further - maybe as early as PagedApiProcessor; and create if needed here
    attachment_processor = Canvas::AttachmentsProcessor.new({})

    submissions.each do |submission|
      user_id    = submission['user_id']
      assignment_id = submission['assignment_id']
      attachment_data = []
      if  submission['attachments']
# <<<<<<< HEAD
        submission['attachments'].each do |attachment|
          attachment_data << {'author' =>  smap[user_id], 'id' => attachment['id'],
                              'source' => attachment['url'], 'type' => 'image',
                              'comments' => [], 'numComments' => 0,
                              'date' => Time.parse(attachment['updated_at']).to_s(:gallery)}
# =======
        previously_credited = Activity.where({canvas_scoring_item_id: submission['assignment_id'],
            reason: 'Submission', canvas_user_id: submission['user_id']}).first

        ## Attachments on a submission are processed in two cases:
        #     1. It has not been done before for this student and this assignment, or
        #     2. The assignment has been resubmitted (the date is after the already credited date)
        if previously_credited.nil? || (previously_credited.canvas_updated_at.to_time != Time.parse(submission['submitted_at']))
          attachment_processor.attachment_conf = { content_type:submission['content-type'], canvas_user_id: submission['user_id'],
             assignment_id: submission['assignment_id'], submission_id: submission['id'], author: smap[submission['user_id']]}
          attachment_processor.call(submission['attachments'])
          previously_credited.update_attribute(:canvas_updated_at, submission['submitted_at']) if previously_credited
# >>>>>>> 8c83dbbc6964f9c308494958ad8a805a2e61d1b4
        end
      end
    end

      if user_id   && !(scored_submissions.include?([assignment_id, user_id]))
        Activity.score!({canvas_scoring_item_id: assignment_id,
                         canvas_user_id: user_id, reason: 'Submission',
                         body: attachment_data.to_json,
                         score: submission_conf.active, delta: submission_conf.points_associated,
                         canvas_updated_at: submission['submitted_at'] })
      end
    end

  end

end
