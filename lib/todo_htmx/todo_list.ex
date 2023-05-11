defmodule TodoHtmx.TodoList do
  def new() do
    []
  end

  def add_note(notes, note) do
    new_note = add_id(notes, note)
    [new_note | notes]
  end

  def update_note(note, notes) do
    update_in(notes, [Access.filter(& &1.id == note.id)], fn _ -> note end)
  end

  def get_all_notes(notes) do
    notes
  end

  def get_note_by_id(id, notes) do
    Enum.find(notes, fn note -> Map.get(note, :id) == id end)
  end

  def delete_note(id, notes) do
    notes |> Enum.reject(fn note -> Map.get(note, :id) == id end)
  end

  defp add_id(notes, note) do
    last_note = List.first(notes, %{id: 0})
    %{note | id: last_note.id + 1}
  end
end