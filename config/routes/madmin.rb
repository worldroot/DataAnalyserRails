# Below are the routes for madmin
namespace :madmin do
  resources :forums
  resources :activite_tfs
  resources :categorie_tfs
  resources :answers
  resources :students
  resources :questions
  namespace :active_storage do
    resources :blobs
  end
  resources :notifications
  resources :users
  namespace :active_storage do
    resources :variant_records
  end
  namespace :active_storage do
    resources :attachments
  end
  resources :services
  resources :announcements
  root to: "dashboard#show"
end
