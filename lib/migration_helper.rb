module Paperclip
  module MigrationHelper
    module TableDefinition
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def paperclip(name = 'attachment')
          column("#{name}_file_name", :string)
          column("#{name}_content_type", :string)
          column("#{name}_file_size", :integer)
        end
      end      
    end
    
    module Schema
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def add_paperclip_columns(table_name, name)
          add_column(table_name, "#{name}_file_name", :string)
          add_column(table_name, "#{name}_content_type", :string)
          add_column(table_name, "#{name}_file_size", :string)
        end
        
        def remove_paperclip_columns(table_name, name)
          remove_column(table_name, "#{name}_file_name")
          remove_column(table_name, "#{name}_content_type")
          remove_column(table_name, "#{name}_file_size")
        end
      end      
    end
  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, Paperclip::MigrationHelper::TableDefinition)
ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:include, Paperclip::MigrationHelper::Schema)