require 'rails_helper'

RSpec.describe Api::V1::CommentsController, :type => :controller do

  let(:valid_comment_json_response) {
    {
      commentID: 1,
      photoID: 10,
      content: "This is a practice comment"
    }
  }

  let(:valid_session) {
    {canvas_user_id: 5}
  }

  before(:all) do
    PointsConfiguration.delete_all
    Activity.delete_all
    PointsConfiguration.create({interaction: "GalleryComment", points_associated: 7,
                                active: true, pcid: 3})
  end

  describe "POST update" do
    it "responds with a 200 with valid params" do
      expect{
        FactoryGirl.create(:student, canvas_user_id: 5)
        post :create, valid_comment_json_response, valid_session
      }.to change(Comment, :count).by(1)
    end

    it "responds with a 400 with invalid params" do
      FactoryGirl.create(:student, canvas_user_id: 5)
      valid_comment_json_response.delete(:commentID)
      post :create, valid_comment_json_response, valid_session
      expect(response.response_code).to eq(400)
    end

    it "does not create a new object with invalid params" do
      expect{
        FactoryGirl.create(:student, canvas_user_id: 5)
        valid_comment_json_response.delete(:commentID)
        post :create, valid_comment_json_response, valid_session
      }.to change(Comment, :count).by(0)
    end

  end

end
