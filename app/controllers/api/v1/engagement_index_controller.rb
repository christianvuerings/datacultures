class Api::V1::EngagementIndexController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def index
    students = Student.all
    activity_sums = Activity.student_scores
    last_activity_dates = Activity.select(:canvas_updated_at, :canvas_user_id).group(:canvas_user_id).maximum(:canvas_updated_at)
    render :json => engagement_index_json(students, activity_sums, last_activity_dates)
  end

  private
    def engagement_index_json(students, student_points, last_activity_dates) #creates a json that can be read by the front end EI
      students_array = []
      students.each do |student|
        student_hash = {}
        id = student[:canvas_user_id]
        student_hash[:id] = id
        student_hash[:name] = student[:name]
        student_hash[:sortable_name] = student[:sortable_name]
        student_hash[:points] = student_points[student[:canvas_user_id]] || 0 #if points exist for user, then set to points, else 0
        student_hash[:position] = 1
        student_hash[:section] = student[:section]
        student_hash[:share] = student[:share]
        student_hash[:last_activity_date] = last_activity_dates[id] ? last_activity_dates[id].to_time.strftime("%m-%d-%Y %l:%M %p") : nil #if an activity (date) doesn't exist for user, then just return nil
        students_array << student_hash
      end
      engagement_index_json = {}
      engagement_index_json["students"] = students_array.sort_by {|h| h[:id]}
      engagement_index_json["current_canvas_user"] = students.where({canvas_user_id: session[:canvas]['user_id'].to_i}).first
      engagement_index_json["current_canvas_user_points"] = student_points[session[:canvas]['user_id'].to_i] || 0
      return engagement_index_json
    end
end
