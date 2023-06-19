defmodule TodoHtmxWeb.TodoController do
  use TodoHtmxWeb, :controller
  alias TodoHtmx.TodoServer
  require Logger

  def index(conn, params) do
    todos = TodoServer.all_todos()
    case Map.fetch(params, "note") do
      {:ok , note} ->
        search_todos = TodoServer.search_todo(todos, note)
        render(conn, "search.html", layout: false, todos: search_todos)
      :error -> 
        render(conn, "index.html", todos: todos)
    end
  end

  def show(conn, %{"id" => id}) do
    id = String.to_integer(id)
    todo = find_todo_by_id(id)
    Logger.info(todo)
    render(conn, "show.html", layout: false, todo: todo)
  end

  def create(conn, params) do
    note = Map.get(params, "note")
    TodoServer.all_todos()
    |> TodoServer.create_todo(%{note: note, id: nil})

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

  def update(conn, %{"id" => id, "note" => note}) do
    id = String.to_integer(id)
    todo = %{id: id, note: note}
    Logger.info(note)
    TodoServer.all_todos() |> TodoServer.update_todo(todo)

    todo = find_todo_by_id(id)

    conn
      |> put_flash(:info, "Note updated successfully.")
      |> render("show.html", layout: false, todo: todo)
  end

  def delete(conn, %{"id" => id}) do
    id = String.to_integer(id)
    TodoServer.all_todos() |> TodoServer.delete_todo(id)

    conn
      |> put_flash(:info, "Note deleted successfully.")
      |> send_resp(201, "")
  end

  def bulk_delete(conn, %{"ids" => ids}) do
    Enum.map(ids, fn id ->  
      id = String.to_integer(id)
      TodoServer.all_todos() |> TodoServer.delete_todo(id)
    end)
    todos = TodoServer.all_todos()
    
    conn
      |> put_flash(:info, "Note deleted successfully.")
      |> render("search.html", layout: false, todos: todos)
  end

  defp find_todo_by_id(id) do
    TodoServer.all_todos() 
    |> TodoServer.get_todo(id)
  end
end
