Rails.application.routes.draw do

  root :to => 'bootstrap#index'
  post '/canvas/embedded/*url' => 'canvas_lti#embedded', defaults: { format: 'html' }
  get '/canvas/lti_engagement_index' => 'canvas_lti#lti_engagement_index', defaults: { format: 'xml' }
  get '/canvas/lti_points_configuration' => 'canvas_lti#lti_points_configuration', defaults: { format: 'xml'}
  get '/canvas/lti_gallery' => 'canvas_lti#lti_gallery', defaults: { format: 'xml'}
  get '/users/:course_id' => 'canvas_lti#students_list', defaults: { format: 'json'}

  namespace :api do
    namespace :v1 do
      resources :activities, only: [:index, :show, :create, :update]
      get '/user_info/me' => 'user_info#show', defaults: { format: 'json'}
      get '/engagement_index/data' => 'engagement_index#index', defaults: { format: 'json'}
      post '/students/:canvas_id' => 'students#update'
      get '/students/:canvas_id' => 'students#show'
      get '/gallery/index' => 'gallery#index', defaults: { format: 'json'}
      resources :points_configuration, only: [:index, :update]
      post '/comments/new(/:comment_id)' => 'comments#create'
      get '/comments/:submission_id' => 'comments#show'
      resources :likes, only: [:index, :create]
      put '/likes' => 'likes#update'
      patch '/likes' => 'likes#update'
    end
  end

  get '/*url' => 'bootstrap#index', defaults: { format: 'html' }
end
