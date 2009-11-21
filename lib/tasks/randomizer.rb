namespace :randomizer do

  desc "Test generating a random avatar URL"
  task :avatar => [:environment] do
    puts RandomUser.new.avatar_url
  end

end