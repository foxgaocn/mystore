require 'rake'
namespace :import do
  task :products => :environment do
    Spree::ProductImport.new.import_data!
  end
end