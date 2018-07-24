defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare(a, b) do
    cond do
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(a, b) do
    Enum.chunk_every(b, Enum.count(a), 1)
    |> Enum.map(fn
      b1 when b1 === a -> true
      _ -> false
    end)
    |> Enum.any?()
  end
end
