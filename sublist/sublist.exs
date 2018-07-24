defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(a, b) do
    Stream.chunk_every(b, Enum.count(a), 1)
    |> Task.async_stream(&(&1 === a), ordered: false)
    |> Stream.map(fn {:ok, val} -> val end)
    |> Enum.any?()
  end
end
