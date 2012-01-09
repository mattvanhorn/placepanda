Placepanda::Application.routes.draw do
  root :to => 'pages#home'
  match '/:width/:height', :to => 'pandas#color'
  match '/g/:width/:height', :to => 'pandas#grayscale'
  match '/attribution', :to => 'pages#attribution'
end
