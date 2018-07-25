defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1, do: raise ArgumentError
  def nth(count), do: do_nth(count, floor: 2, ceiling: count + 4, primes: [2])

  def do_nth(count, floor: _floor, ceiling: _ceiling, primes: primes) when length(primes) >= count, do: Enum.reverse(primes) |> Enum.at(count - 1)
  def do_nth(count, floor: floor, ceiling: ceiling, primes: primes) do
    composites = Enum.map(primes, &get_composites(&1, floor, ceiling))
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
    case get_next_prime(composites, floor, ceiling) do
      nil -> do_nth(count, floor: ceiling, ceiling: ceiling + 1000, primes: primes)
      prime -> do_nth(count, floor: prime + 1, ceiling: ceiling, primes: [prime | primes])
    end
  end

  def get_composites(prime, floor, ceiling) do
    floor = revise_floor(prime, floor)
    count = div(ceiling - floor, prime) + 1
    Stream.iterate(floor, &(&1 + prime))
    |> Stream.take(count)
    |> Enum.reduce(MapSet.new(), &MapSet.put(&2, &1))
  end

  defp revise_floor(prime, floor) when prime == floor, do: prime
  defp revise_floor(prime, floor), do: floor - rem(floor, prime)

  def get_next_prime(composites, floor, ceiling) do
    Stream.iterate(floor, &(&1 + 1 ))
    |> Stream.take(ceiling - floor)
    |> Enum.find(&(!MapSet.member?(composites, &1)))
  end
end
