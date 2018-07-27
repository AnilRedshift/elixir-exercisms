defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    String.replace(sentence, ~r/[- ]/, "")
    |> String.graphemes()
    |> Enum.reduce_while(MapSet.new(), fn letter, set ->
      case MapSet.member?(set, letter) do
        true -> {:halt, false}
        false -> {:cont, MapSet.put(set, letter)}
      end
    end)
    |> (&(!!&1)).()
  end
end
