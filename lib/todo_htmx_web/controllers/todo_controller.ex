defmodule TodoHtmxWeb.TodoController do
  use TodoHtmxWeb, :controller
  alias TodoHtmx.TodoServer
  require Logger
  plug :put_layout, false when action in [:edit, :show]

  def index(conn, _params) do
    todos = TodoServer.all_notes()
    Logger.info(todos)
    render(conn, "index.html", todos: todos)
  end

  def show(conn, %{"id" => id}) do
    id = String.to_integer(id)
    todo = find_todo_by_id(id)
    Logger.info(todo)
    render(conn, "show.html", todo: todo)
  end

  def create(conn, params) do
    note = Map.fetch!(params, "note")
    TodoServer.all_notes()
    |> TodoServer.create_note(%{note: note, id: 1})

    conn
      |> put_flash(:info, "Note created successfully.")
      |> redirect(to: Routes.todo_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    id = String.to_integer(id)
    todo = find_todo_by_id(id)
    Logger.info(todo)
    render(conn, "edit.html", todo: todo)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    
  end

  defp formatted_todos(todos) do
    todos 
    |> Enum.sort_by(& &1.id)
    |> Enum.map(&"#{&1.id} #{&1.note}")
  end

  defp find_todo_by_id(id) do
    TodoServer.all_notes() 
    |> TodoServer.get_note(id)
    |> List.first
  end
end
