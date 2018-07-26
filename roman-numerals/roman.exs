defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @values [
    'IVX',
    'XLC',
    'CDM',
    'MMM',
  ]
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    Enum.reduce_while(@values, {number, []}, fn [ones, fives, tens], {number, acc} ->
      new_romans = case rem(number, 10) do
        0 when number == 10 -> [tens]
        x when x in 0..3 -> List.duplicate(ones, x)
        4 -> [ones, fives]
        x when x in 5..8 -> [fives, List.duplicate(ones, x - 5)]
        9 -> [ones, tens]
      end

      case number > 10 do
        true -> {:cont, {div(number, 10), [new_romans | acc]}}
        false -> {:halt, IO.iodata_to_binary([new_romans | acc])}
      end
    end)
  end
end
