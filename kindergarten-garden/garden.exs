defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @default_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    Enum.sort(student_names)
    |> Enum.zip(parse_info(info_string))
    |> Enum.into(%{})
  end

  defp parse_info(info_string) do
    String.split(info_string, "\n")
    |> Stream.map(fn row ->
      String.to_charlist(row)
      |> Stream.map(fn
        ?R -> :radishes
        ?C -> :clover
        ?G -> :grass
        ?V -> :violets
      end)
    end)
    |> Stream.zip()
    |> Stream.concat(Stream.cycle([{nil, nil}]))
    |> Stream.chunk_every(2)
    |> Stream.map(fn
      [{nil, nil}, {nil, nil}] -> {}
      [{a, b}, {c, d}] -> {a, c, b, d}
    end)
  end
end
