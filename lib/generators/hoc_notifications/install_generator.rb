require 'rails/generators/migration'

module HocNotifications
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def copy_migration_files
        migration_template "migration/create_hoc_notifications.rb", "db/migrate/create_hoc_notifications.rb"
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          sleep 1 # make sure each time we get a different timestamp
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end
