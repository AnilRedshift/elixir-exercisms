defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @verses [
    {"first", "and a Partridge in a Pear Tree"},
    {"second", "two Turtle Doves"},
    {"third", "three French Hens"},
    {"fourth", "four Calling Birds"},
    {"fifth", "five Gold Rings"},
    {"sixth", "six Geese-a-Laying"},
    {"seventh", "seven Swans-a-Swimming"},
    {"eighth", "eight Maids-a-Milking"},
    {"ninth", "nine Ladies Dancing"},
    {"tenth", "ten Lords-a-Leaping"},
    {"eleventh", "eleven Pipers Piping"},
    {"twelfth", "twelve Drummers Drumming"}
  ]

  @spec verse(number :: integer) :: String.t()
  def verse(number) when number == 1, do: "On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree."
  def verse(number) do
    slice = @verses |> Enum.slice(0..number-1) |> Enum.reverse()
    [{num, _} | _] = slice
    prefix = "On the #{num} day of Christmas my true love gave to me, "

    child_verses = slice
    |> Enum.map(&elem(&1, 1))
    |> Enum.join(", ")

    prefix <> child_verses <> "."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    v = for n <- starting_verse..ending_verse, into: "", do: verse(n) <> "\n"
    String.trim(v, "\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: TwelveDays.verses(1, 12)
end
