defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do: {:error, "Lists must be the same length"}
  def hamming_distance(strand1, strand2) do
    count = Enum.zip(strand1, strand2)
    |> Enum.reject(fn {a,b} -> a == b end)
    |> Enum.count()
    {:ok, count}
  end
end
