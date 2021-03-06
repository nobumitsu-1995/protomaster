Rails.application.routes.draw do

  get 'user/create'
  get 'half_product/new' => "half_product#new"
  get "half_product/index" => "half_product#index"
  get "half_product/sort_code" => "half_product#sort_code"
  get "half_product/sort" => "half_product#sort"
  post "half_product/create" => "half_product#create"
  get "half_product/:id/show" => "half_product#show"
  post "half_product/:id/destroy" => "half_product#destroy"
  get "half_product/:id/edit" => "half_product#edit"
  post "half_product/:id/update" => "half_product#update"

  get 'pigment/new' => "pigment#new"
  get "pigment/index" => "pigment#index"
  get "pigment/sort_code" => "pigment#sort_code"
  get "pigment/sort_maker" => "pigment#sort_maker"
  get "pigment/sort_pig_no" => "pigment#sort_pig_no"
  get "pigment/sort" => "pigment#sort"
  post "pigment/create" => "pigment#create"
  get "pigment/:id/show" => "pigment#show"
  post "pigment/:id/destroy" => "pigment#destroy"
  get "pigment/:id/edit" => "pigment#edit"
  post "pigment/:id/update" => "pigment#update"

  get '/' => "home#top"

  get "prototype/new" => "prototype#new"
  get "prototype/index" => "prototype#index"
  get "prototype/sort_client" => "prototype#sort_client"
  get "prototype/sort_createdDate" => "prototype#sort_createdDate"
  get "prototype/sort" => "prototype#sort"
  post "prototype/sort_client" => "prototype#sort_client"
  post "prototype/sort_createdDate" => "prototype#sort_createdDate"
  post "prototype/sort" => "prototype#sort"
  post "prototype/create" => "prototype#create"
  get "prototype/report" => "prototype#report"
  get "prototype/write_report" => "prototype#write_report"
  get "prototype/:id/show" => "prototype#show"
  get "prototype/:id/new_mb" => "prototype#new_mb"
  get "prototype/:id/new_pc" => "prototype#new_pc"
  post "prototype/:id/update_mb" => "prototype#update_mb"
  post "prototype/:id/update_pc" => "prototype#update_pc"
  post "prototype/:id/destroy_datas" => "prototype#destroy_datas"
  post "prototype/:id/destroy_proto" => "prototype#destroy_proto"
  get "prototype/:id/edit_proto" => "prototype#edit_proto"
  post "prototype/:id/update_proto" => "prototype#update_proto"
  get "prototype/:id/:table/data" => "prototype#data"
  get "prototype/:id/:table/edit_data" => "prototype#edit_data"
  post "prototype/:id/:table/update_data" => "prototype#update_data"
  post "prototype/:id/:table/destroy_data" => "prototype#destroy_data"
  get "prototype/:id/add_data" => "prototype#add_data"
  post "prototype/:id/add_data_update" => "prototype#add_data_update"

  get "user/login_form" => "user#login_form"
  post "user/login" => "user#login"
  post "user/logout" => "user#logout"
  get "user/create" => "user#create"
  get "user/edit" => "user#edit"
  get "user/show" => "user#show"
  post "user/signin" => "user#signin"
  post "user/update" => "user#update"
  post "user/destroy" => "user#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
