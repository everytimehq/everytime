# Everytime

Add this line to your application's Gemfile:

    gem 'everytime'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everytime

## Usage

	project = Everytime::Project.new(name: "test todo lists")
	project.save

	medium = Everytime::Medium.new(path: "https://vimeo.com/13247598", project_id: project.id)
	medium.save

	bookmark = Everytime::Bookmark.new(title: "super moment", start_time: 50000, medium_id: medium.id)
	bookmark.save

	todo_list = Everytime::TodoList.new(name: "todo list", project_id: project.id)
	todo_list.save

	todo_item = Everytime::TodoItem.new(text: "shopping", todo_list_id: todo_list.id)
	todo_item.save

	storyboard = Everytime::Storyboard.new(name: "todo list", project_id: project.id)
	storyboard.save

	drawing = Everytime::Drawing.new(text: "[]", storyboard_id: storyboard.id)
	drawing.save

