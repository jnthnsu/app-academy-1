namespace :prune do
  desc "prunes old urls"
  task :prune, [:n] => :environment do |t, args|
    ShortenedUrl.prune(args[:n].to_i)
  end
end
