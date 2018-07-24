defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.reduce(factors, MapSet.new(), fn factor, set ->
      Stream.iterate(0, &(&1 + factor))
      |> Stream.take_while(&(&1 < limit))
      |> Enum.reduce(set, fn num, set -> MapSet.put(set, num) end)
    end)
    |> Enum.sum()
  end
end
