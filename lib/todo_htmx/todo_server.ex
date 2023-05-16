defmodule TodoHtmx.TodoServer do
	use GenServer
	alias TodoHtmx.TodoList

	# Client
	def start_link(_args) do
	  GenServer.start_link(__MODULE__, [], name: __MODULE__)
	end

	def all_todos do
	  GenServer.call(__MODULE__, :all_todos)
	end

	def create_todo(_pid, note) do
	  GenServer.cast(__MODULE__, {:create_todo, note})
	end

	def get_todo(_pid, id) do
	  GenServer.call(__MODULE__, {:get_todo, id})
	end

	def delete_todo(_pid, id) do
	  GenServer.cast(__MODULE__, {:delete_todo, id})
	end

	def update_todo(_pid, note) do
	  GenServer.cast(__MODULE__, {:update_todo, note})
	end

	def search_todo(_pid, note) do
	  GenServer.call(__MODULE__, {:search_todo, note})
	end

	# Server
	@impl true
	def init(_) do
	  {:ok, TodoList.new()}
	end

	@impl true
	def handle_call(:all_todos, _from, todo_list) do
	  {:reply, todo_list, todo_list}
	end

	@impl true
	def handle_cast({:create_todo, note}, todo_list) do
	  updated_todo_list = TodoList.add_todo(todo_list, note)
	  {:noreply, updated_todo_list}
	end

	@impl true
	def handle_call({:get_todo, id}, _from, todo_list) do
	  found_todo = TodoList.get_todo_by_id(todo_list, id)
	  {:reply, found_todo, todo_list}
	end

	@impl true
	def handle_cast({:delete_todo, id}, todo_list) do
	  updated_todo_list = TodoList.delete_todo(todo_list, id)
	  {:noreply, updated_todo_list}
	end

	@impl true
	def handle_cast({:update_todo, todo}, todo_list) do
	  updated_todo_list = TodoList.update_todo(todo_list, todo)
	  {:noreply, updated_todo_list}
	end

	@impl true
	def handle_call({:search_todo, note}, _from, todo_list) do
	  found_todo_list = TodoList.search_todo(todo_list, note)
	  {:reply, found_todo_list, todo_list}
	end
end