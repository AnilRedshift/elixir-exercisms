defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    case valid?(digits, base_a, base_b) do
      false -> nil
      true -> parse(digits, base_a) |> to_base(base_b)
    end
  end

  defp parse(digits, base_a) do
    Enum.reverse(digits)
      |> Enum.with_index()
      |> Enum.map(fn {num, power} ->
        :math.pow(base_a, power) * num
      end)
      |> Enum.sum()
      |> trunc()
  end

  defp to_base(0, _base), do: [0]
  defp to_base(num, base) do
    num_digits = :math.log(num) / :math.log(base)
    |> trunc()

    (for x <- 0..num_digits, do: :math.pow(base, x) |> trunc())
    |> Enum.reverse()
    |> Enum.map_reduce(num, fn place, num ->
      {div(num, place), rem(num, place)}
    end)
    |> elem(0)
  end

  defp valid?([], _, _), do: false
  defp valid?(_, base_a, base_b) when base_a <= 1 or base_b <= 1, do: false
  defp valid?(digits, base_a, _base_b) do
    Enum.all?(digits, &(&1 >= 0 && &1 < base_a))
  end
end
