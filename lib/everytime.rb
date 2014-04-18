require "everytime/version"
require 'active_resource'

module Everytime

	class Resource < ActiveResource::Base
		API_ROOT = "/api/v1"

		# def self.auth_token=(token)
			
		# end
		self.site = (ENV["RAKE_ENV"] == "test") ? "http://localhost:5000" : "https://www.everytimehq.com"

		def self.parent_resource(parent)
			@parent_resource = parent
		end

		def self.prefix_source
			API_ROOT + "/" + ( @parent_resource ? "#{@parent_resource.to_s.pluralize}/:#{@parent_resource}_id" : "" )
		end

		def self.check_prefix_options(options)
		end

		def self.prefix(options = {})
			args = options.any? ? options.map { |name, value| "/#{name.to_s.chomp('_id').pluralize}/#{value}" }.join : ""
			API_ROOT + args + "/"
		end

		def self.all(options = {})
			find(:all, options)
		end

		def self.first(options = {})
			find(:first, options)
		end

		def self.last(options = {})
			find(:last, options)
		end

		def self.prefix_options
			id ? {} : super
		end

	end


	class Bookmark < Resource
		parent_resource :medium
	end
	class Drawing < Resource
		parent_resource :storyboard
	end
	class TodoItem < Resource
		parent_resource :todo_list
	end

	class Medium < Resource
		parent_resource :project
		#has_many :bookmarks
	end
	class Storyboard < Resource
		parent_resource :project
		#has_many :drawings
	end
	class TodoList < Resource
		parent_resource :project
		#has_many :todo_items
	end
	
	class Project < Resource
		has_many :media, class_name: "Everytime::Medium"
		# has_many :todo_lists
		# has_many :storyboards
		# has_many :play_lists
	end



end


