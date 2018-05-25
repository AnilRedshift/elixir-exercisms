defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) when rem(number, 105) == 0, do: "PlingPlangPlong"
  def convert(number) when rem(number, 15) == 0, do: "PlingPlang"
  def convert(number) when rem(number, 21) == 0, do: "PlingPlong"
  def convert(number) when rem(number, 35) == 0, do: "PlangPlong"
  def convert(number) when rem(number, 3) == 0, do: "Pling"
  def convert(number) when rem(number, 5) == 0, do: "Plang"
  def convert(number) when rem(number, 7) == 0, do: "Plong"
  def convert(number), do: Integer.to_string(number)
end
