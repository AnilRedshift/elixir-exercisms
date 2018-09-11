defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}

  def generate(coins, target) do
    do_generate(coins, target, %{0 => []})
    |> Map.fetch(target)
    |> case do
      {:ok, val} -> {:ok, val}
      :error -> {:error, "cannot change"}
    end
  end

  defp do_generate(coins, target, cache) when target <= 0, do: cache
  defp do_generate(coins, target, cache) do
    case Map.fetch(cache, target) do
      {:ok, change} -> cache
      :error ->
        Enum.reduce(coins, cache, fn coin, cache ->
        cache = do_generate(coins, target - coin, cache)
        case cache[target - coin] do
          nil -> cache
          _change -> update_cache(cache, target, coin)
        end
      end)
    end
  end

  defp update_cache(cache, target, coin) do
    change = [coin | cache[target - coin]]
    Map.update(cache, target, change, fn
      existing when length(change) < length(existing) -> change
      existing -> existing
    end)
  end
end
