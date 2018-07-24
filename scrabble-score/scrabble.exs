defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    String.downcase(word)
    |> String.to_charlist()
    |> Task.async_stream(fn
      c when c in 'aeioulnrst' -> 1
      c when c in 'dg' -> 2
      c when c in 'bcmp' -> 3
      c when c in 'fhvwy' -> 4
      ?k -> 5
      c when c in 'jx' -> 8
      c when c in 'qz' -> 10
      _ -> 0
    end, ordered: false)
    |> Stream.map(fn {:ok, val} -> val end)
    |> Enum.sum()
  end
end
