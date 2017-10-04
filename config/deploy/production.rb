role :app, ENV["DEPLOY_SERVER"]
role :web, ENV["DEPLOY_SERVER"]
role :db,  ENV["DEPLOY_SERVER"]