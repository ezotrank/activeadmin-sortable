require 'activeadmin-sortable/version'
require 'activeadmin'
require 'rails/engine'

module ActiveAdmin
  module Sortable
    module ControllerActions
      def sortable
        member_action :sort, :method => :post do
          if resource.class.name == 'MovieEpisode'
            episodes = resource.movie.episodes.delete_if {|e| e == resource}
            index = 0
            episodes.each do |episode|
              if index == params[:position].to_i
                resource.update_attribute(:position, index)
                index += 1
              end
              episode.update_attribute(:position, index)
              index += 1
            end
          else
            resource.insert_at params[:position].to_i
          end
          head 200
        end
      end
    end

    module TableMethods
      HANDLE = '&#x2195;'.html_safe

      def sortable_handle_column
        column '' do |resource|
          sort_url = url_for([:sort, :admin, resource])
          content_tag :span, HANDLE, :class => 'handle', 'data-sort-url' => sort_url
        end
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

    class Engine < ::Rails::Engine
      # Including an Engine tells Rails that this gem contains assets
    end
  end
end
