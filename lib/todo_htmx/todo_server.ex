defmodule TodoHtmx.TodoServer do
	use GenServer
	alias TodoHtmx.TodoList

	# Client
	def start_link(_args) do
	  GenServer.start_link(__MODULE__, [], name: __MODULE__)
	end

	def all_notes do
	  GenServer.call(__MODULE__, :all_notes)
	end

	def create_note(_pid, note) do
	  GenServer.cast(__MODULE__, {:create_note, note})
	end

	def get_note(_pid, id) do
	  GenServer.call(__MODULE__, {:get_note, id})
	end

	def delete_note(_pid, id) do
	  GenServer.cast(__MODULE__, {:delete_note, id})
	end

	def update_note(_pid, note) do
	  GenServer.cast(__MODULE__, {:update_note, note})
	end

	# Server
	@impl true
	def init(_) do
	  {:ok, TodoList.new()}
	end

	@impl true
	def handle_cast({:create_note, note}, notes) do
	  updated_notes = TodoList.add_note(notes, note)
	  {:noreply, updated_notes}
	end

	@impl true
	def handle_cast({:delete_note, id}, notes) do
	  updated_notes = TodoList.delete_note(id, notes)
	  {:noreply, updated_notes}
	end

	@impl true
	def handle_cast({:update_note, note}, notes) do
	  updated_notes = TodoList.update_note(note, notes)
	  {:noreply, updated_notes}
	end

	@impl true
	def handle_call({:get_note, id}, _from, notes) do
	  found_note = TodoList.get_note_by_id(id, notes)
	  {:reply, found_note, notes}
	end

	@impl true
	def handle_call(:all_notes, _from, notes) do
	  {:reply, notes, notes}
	end
end