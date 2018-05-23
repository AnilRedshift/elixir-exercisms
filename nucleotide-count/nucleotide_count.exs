defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide), do: Enum.count(strand, &(&1 == nucleotide))

  # If done manually:
  # def count([], _), do: 0
  # def count([first | strand], nucleotide) when first == nucleotide do
  #   1 + count(strand, nucleotide)
  # end
  # def count([_ | strand], nucleotide), do: count(strand, nucleotide)

  # old solution
  # @empty_histogram Enum.into(@nucleotides, %{}, fn n -> {n,0} end)
  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  # def histogram(strand) do
  #   Enum.reduce(strand, @empty_histogram, fn c, histogram ->
  #     Map.update!(histogram, c, &(&1 + 1))
  #   end)
  # end
end
