# RAKE_ENV=test EVERYTIME_API_TOKEN=xEBMjjVqP3tF4Hjzze9P rake test
# console: irb -Ilib -reverytime

require "minitest/autorun"
require 'active_support/testing/assertions'
include ActiveSupport::Testing::Assertions

require 'everytime'

class EverytimeTest < Minitest::Test

	Everytime::Resource.user = ENV["EVERYTIME_API_TOKEN"]
	

	def test_projects
		project_id = nil
		assert_difference 'Everytime::Project.all.count', 1 do
			project = Everytime::Project.new(name: "test project")
			assert project.save
			project_id = project.id
			assert project_id
		end

		project = Everytime::Project.find(project_id)
		assert_equal project.name, "test project"

		project.name = "changed name 2"
		assert project.save

		project.reload
		assert_equal project.name, "changed name 2"

		assert_difference 'Everytime::Project.all.count', -1 do
			project.destroy
		end

		assert_equal Everytime::Project.all.count, 0

	end

	def test_media
		project = Everytime::Project.new(name: "test media")
		assert project.save

		assert_difference 'project.reload.media.count', 1 do
			medium = Everytime::Medium.new(path: "https://vimeo.com/13247598", project_id: project.id)
			assert medium.save
		end

		medium_id = project.media.last.id
		medium = Everytime::Medium.find(medium_id)
		assert medium.exists?

		assert_equal medium.title, "\"Puppet\" Short Film"
		medium.title = "Short film by Guillaume Fradin"
		assert medium.save

		medium.reload

		assert_equal medium.title, "Short film by Guillaume Fradin"

		bookmark_id = nil
		assert_difference 'medium.reload.bookmarks.count', 1 do
			bookmark = Everytime::Bookmark.new(title: "super moment", start_time: 50000, medium_id: medium.id)
			assert bookmark.save
			bookmark_id = bookmark.id
		end

		bookmark = Everytime::Bookmark.find(bookmark_id)
		bookmark.title = "changed"
		bookmark.save

		bookmark.reload
		assert_equal bookmark.title, "changed"

		assert_difference 'medium.reload.bookmarks.count', -1 do
			bookmark.destroy
		end

		assert_difference 'project.reload.media.count', -1 do
			medium.destroy
		end

		project.destroy

		assert_equal Everytime::Project.all.count, 0

	end

	def test_todo_lists
		project = Everytime::Project.new(name: "test todo lists")
		assert project.save

		assert_difference 'project.reload.todo_lists.count', 1 do
			todo_list = Everytime::TodoList.new(name: "todo list", project_id: project.id)
			assert todo_list.save
		end

		todo_list_id = project.todo_lists.last.id
		todo_list = Everytime::TodoList.find(todo_list_id)
		assert todo_list.exists?

		assert_equal todo_list.name, "todo list"
		todo_list.name = "to do quickly"
		assert todo_list.save

		todo_list.reload

		assert_equal todo_list.name, "to do quickly"

		todo_item_id = nil
		assert_difference 'todo_list.reload.items.count', 1 do
			todo_item = Everytime::TodoItem.new(text: "shopping", todo_list_id: todo_list.id)
			assert todo_item.save
			todo_item_id = todo_item.id
		end

		todo_item = Everytime::TodoItem.find(todo_item_id)
		todo_item.text = "changed"
		todo_item.save

		todo_item.reload
		assert_equal todo_item.text, "changed"

		assert_difference 'todo_list.reload.items.count', -1 do
			todo_item.destroy
		end

		assert_difference 'project.reload.todo_lists.count', -1 do
			todo_list.destroy
		end

		project.destroy

		assert_equal Everytime::Project.all.count, 0
	end

	def test_storyboards
		project = Everytime::Project.new(name: "test storyboards")
		assert project.save

		assert_difference 'project.reload.storyboards.count', 1 do
			storyboard = Everytime::Storyboard.new(name: "todo list", project_id: project.id)
			assert storyboard.save
		end

		storyboard_id = project.storyboards.last.id
		storyboard = Everytime::Storyboard.find(storyboard_id)
		assert storyboard.exists?

		assert_equal storyboard.name, "todo list"
		storyboard.name = "to do quickly"
		assert storyboard.save

		storyboard.reload

		assert_equal storyboard.name, "to do quickly"

		drawing_id = nil
		assert_difference 'storyboard.reload.items.count', 1 do
			drawing = Everytime::Drawing.new(text: "shopping", storyboard_id: storyboard.id)
			assert drawing.save
			drawing_id = drawing.id
		end

		drawing = Everytime::Drawing.find(drawing_id)
		drawing.text = "changed"
		drawing.save

		drawing.reload
		assert_equal drawing.text, "changed"

		assert_difference 'storyboard.reload.items.count', -1 do
			drawing.destroy
		end

		assert_difference 'project.reload.storyboards.count', -1 do
			storyboard.destroy
		end

		project.destroy

		assert_equal Everytime::Project.all.count, 0
	end

end