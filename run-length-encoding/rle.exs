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
    String.graphemes(string)
    |> Enum.chunk_by(&(&1))
    |> map_join(fn
      [char] -> to_string([char])
      [char | _] = chars -> "#{Enum.count(chars)}#{to_string([char])}"
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d+)(\D)|\D/, string)
    |> map_join(fn
      [letter] -> letter
      [_, count, letter] -> String.duplicate(letter, String.to_integer(count))
    end)
  end

  defp map_join(list, fun), do: Enum.map(list, fun) |> Enum.join()
end
