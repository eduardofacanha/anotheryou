Rails.application.routes.draw do

  # constraints subdomain: 'api' do
    namespace :api, path: '/', defaults: {format: 'json'} do
      scope module: :v1 do

        mount_devise_token_auth_for 'User', at: 'users', skip: [:omniauth_callbacks]

        get 'user/followersc', to: 'users#followers'
        get 'user/following', to: 'users#following'
        get 'user/show/:id', to: 'users#show', as: 'user'
        get 'user/relationship/:id', to: 'users#relationship', as: 'user_relationship'
        post 'user/follow/:id', to: 'users#follow'
        delete 'user/unfollow/:id', to: 'users#unfollow'

        get 'pictures/show/:id', to: 'pictures#show'
        post 'pictures/create', to: 'pictures#create'
        put 'pictures/update/:id', to: 'pictures#update'
        delete 'pictures/delete/:id', to: 'pictures#delete'
        post 'pictures/like/:id', to: 'pictures#like'
        post 'pictures/unlike/:id', to: 'pictures#unlike'
        post 'pictures/comment/:id', to: 'pictures#comment'
        get 'pictures/comments/:id', to: 'pictures#comments'

        get 'pictures/sent/:user_id', to: 'pictures#sent'
        get 'pictures/received/:user_id', to: 'pictures#received'

      end
    end
  # end

end
