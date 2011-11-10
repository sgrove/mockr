namespace :bushido do
  desc "Bushido install"
  task :install => "app:install"
end

namespace :app do
  desc "adds the required settings variables to the db"
  task :install => :environment do
    ["subdomain", "domain"].each do |s|
      Setting.find_or_create_by_key :key=>s, :value=>""
    end
  end
end
