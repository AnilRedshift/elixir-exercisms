defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth


  @schedule [:first, :second, :third, :fourth]
  |> Enum.with_index()
  |> Enum.into(%{})

  @days [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  |> Enum.with_index()
  |> Enum.into(%{}, fn {k, v} -> {k, v + 1} end)

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, :teenth) do
    valid_days(year, month, weekday)
    |> Enum.find(fn {_, _, day} -> day >= 13 && day <= 19 end)
  end

  def meetup(year, month, weekday, :last) do
    valid_days(year, month, weekday)
    |> List.last()
  end

  def meetup(year, month, weekday, schedule) do
    count = Map.fetch!(@schedule, schedule)
    valid_days(year, month, weekday)
    |> Enum.at(count)
  end

  defp valid_days(year, month, weekday) do
    valid_day = fn day ->
      :calendar.valid_date(year, month, day) &&
      :calendar.day_of_the_week(year, month, day) == Map.fetch!(@days, weekday)
    end
    
    for day <- (1..31),
      valid_day.(day),
      do: {year, month, day}
  end
end
