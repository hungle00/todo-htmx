defmodule TodoHtmx.TodoList do
  def new() do
    []
  end

  def add_todo(todo_list, note) do
    last_todo = List.first(todo_list, %{id: 0})
    new_todo = %{note | id: last_todo.id + 1}
    [new_todo | todo_list]
  end

  def update_todo(todo_list, note) do
    update_in(todo_list, [Access.filter(& &1.id == note.id)], fn _ -> note end)
  end

  def get_todo_list(todo_list) do
    todo_list
  end

  def get_todo_by_id(todo_list, id) do
    Enum.find(todo_list, fn todo -> Map.get(todo, :id) == id end)
  end

  def search_todo(todo_list, note) do
    todo_list
    |> Enum.filter(&(String.contains?(&1.note, note)))
  end

  def delete_todo(todo_list, id) do
    todo_list |> Enum.reject(fn todo -> Map.get(todo, :id) == id end)
  end
end