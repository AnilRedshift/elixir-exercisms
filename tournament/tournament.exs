defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    [format_row(["Team", "MP", "W", "D", "L", "P"])] ++ (
      Enum.map(input, &String.split(&1, ";"))
      |> Enum.filter(fn
        [_, _, result] when result in ["win", "loss", "draw"] -> true
        _ -> false
      end)
      |> Enum.reduce(%{}, fn
        [a, b, "win"], acc -> win(a, b, acc)
        [a, b, "loss"], acc -> win(b, a, acc)
        [a, b, "draw"], acc -> draw(a, b, acc)
      end)
      |> Enum.sort_by(fn {_name, %{wins: wins, draws: draws}} -> (-3 * wins) - draws end)
      |> Enum.map(fn {name, %{wins: wins, draws: draws, losses: losses}} ->
        mp = wins + draws + losses
        points = trunc((3 * wins) + draws)
        format_row([name, mp, wins, draws, losses, points])
      end)
    )
    |> Enum.join("\n")
  end

  defp win(a, b, results) do
    increment(results, a, :wins)
    |> increment(b, :losses)
  end

  defp draw(a, b, results) do
    increment(results, a, :draws)
    |> increment(b, :draws)
  end

  defp increment(results, name, field) do
    update_in(results, [Access.key(name, %{wins: 0, draws: 0, losses: 0}), field], &(&1 + 1))
  end

  defp format_row([name | vals]) do
    [String.pad_trailing(name, 30)] ++ Enum.map(vals, &format_num/1)
    |> Enum.join(" | ")
  end

  defp format_num(num), do: String.pad_leading(to_string(num), 2)
end
