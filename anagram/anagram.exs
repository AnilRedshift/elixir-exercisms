defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &(hash(&1) == hash(base)))
    |> Enum.filter(&(String.downcase(&1) != String.downcase(base)))
  end

  defp hash(word) do
    updater = &(&1 + 1)
    String.downcase(word)
    |> String.graphemes()
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, updater))
  end
end
