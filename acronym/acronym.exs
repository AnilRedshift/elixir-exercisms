defmodule Acronym do

  @acronyms [
    {"Portable Networks Graphic", "PNG"},
    {"Ruby on Rails", "ROR"},
    {"HyperText Markup Language", "HTML"},
    {"First in, First out", "FIFO"},
    {"Complementary Metal-Oxide semiconductor", "CMOS"}
  ]


  # Extra work to only do one regex pass instead of K acronyms
  # This produces a string like this: ^(portable networks graphic)|(ruby on rails)|...$
  # along with a group name to match
  @re_str @acronyms
  |> Enum.unzip
  |> elem(0)
  |> Enum.map(fn k -> k
    |> String.downcase()
    |> String.replace(~r/[^a-z ]/, "")
    |> Regex.escape()
  end)
  |> Enum.with_index()
  |> Enum.map(fn {k, i} -> "(?<m#{i}>#{k})" end)
  |> Enum.join("|")

  @re Regex.compile("^#{@re_str}$", "i") |> elem(1)

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    match = Regex.named_captures(@re, string)
    |> Map.to_list
    |> Enum.find(fn {_,v} -> v != "" end)

    case match do
      {"m" <> id, _} ->
        Enum.at(@acronyms, String.to_integer(id))
        |> elem(1)
      _ -> string
    end
  end

end
