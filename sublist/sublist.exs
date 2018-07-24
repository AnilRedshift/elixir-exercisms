defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare(a, b) do
    case sublist?(a, b) do
      true -> :sublist
      false -> :superlist
    end
  end

  defp sublist?(a, b) do
    true
  end
end
