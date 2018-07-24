defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    String.downcase(sentence)
    |> String.replace(~r/[^a-zA-Z]/, "")
    |> String.to_charlist()
    |> Enum.reduce(MapSet.new(), &MapSet.put(&2, &1))
    |> MapSet.size()
    |> case do
      26 -> true
      _ -> false
    end
  end
end
