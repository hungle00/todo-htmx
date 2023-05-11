defmodule TodoHtmxWeb.TodoController do
  use TodoHtmxWeb, :controller
  alias TodoHtmx.TodoServer
  require Logger

  def index(conn, _params) do
    todos = TodoServer.all_notes()
    Logger.info(todos)
    render(conn, "index.html", todos: todos)
  end

  def show(conn, %{"id" => id}) do
    id = String.to_integer(id)
    todo = find_todo_by_id(id)
    Logger.info(todo)
    render(conn, "show.html", layout: false, todo: todo)
  end

  def create(conn, params) do
    note = Map.fetch!(params, "note")
    TodoServer.all_notes()
    |> TodoServer.create_note(%{note: note, id: nil})

    conn
      |> put_flash(:info, "Note created successfully.")
      |> redirect(to: Routes.todo_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    id = String.to_integer(id)
    todo = find_todo_by_id(id)
    Logger.info(todo)
    render(conn, "edit.html", layout: false, todo: todo)
  end

  def update(conn, %{"id" => id, "content" => content}) do
    id = String.to_integer(id)
    note = %{id: id, note: content}
    Logger.info(note)
    TodoServer.all_notes() |> TodoServer.update_note(note)

    todo = find_todo_by_id(id)

    conn
      |> put_flash(:info, "Note updated successfully.")
      |> render("show.html", layout: false, todo: todo)
  end

  def delete(conn, %{"id" => id}) do
    id = String.to_integer(id)
    TodoServer.all_notes() 
    |> TodoServer.delete_note(id)

    conn
      |> put_flash(:info, "Note deleted successfully.")
      |> send_resp(201, "")
  end

  defp formatted_todos(todos) do
    todos 
    |> Enum.sort_by(& &1.id)
    |> Enum.map(&"#{&1.id} #{&1.note}")
  end

  defp find_todo_by_id(id) do
    TodoServer.all_notes() 
    |> TodoServer.get_note(id)
  end
end
