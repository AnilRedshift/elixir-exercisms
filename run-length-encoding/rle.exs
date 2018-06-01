defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    String.to_charlist(string)
    |> Enum.chunk_while([], &chunk/2, &last/1)
    |> Enum.map(fn
      [char] -> to_string([char])
      [char | _] = chars -> "#{Enum.count(chars)}#{to_string([char])}"
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d+)(\D)|\D/, string)
    |> Enum.map(fn
      [_, count, letter] -> String.duplicate(letter, String.to_integer(count))
    end)
    |> Enum.join()
  end

  defp chunk(cur, [prev | _] = acc) when cur == prev, do: {:cont, [cur | acc]}
  defp chunk(cur, []), do: {:cont, [cur]}
  defp chunk(cur, acc), do: {:cont, acc, [cur]}

  defp last(acc) when acc == [], do: {:cont, acc}
  defp last(acc), do: {:cont, acc, []}
end
