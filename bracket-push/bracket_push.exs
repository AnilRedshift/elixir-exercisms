defmodule BracketPush do
  @bracket_data [
    {"[", "]"},
    {"{", "}"},
    {"(", ")"}
  ]
  @open_brackets @bracket_data |> Enum.unzip() |> elem(0)
  @close_brackets @bracket_data |> Enum.unzip() |> elem(1)
  @brackets @open_brackets ++ @close_brackets |> Enum.join() |> String.to_charlist()
  @bracket_map Enum.into(@bracket_data, %{}, fn {open, close} -> {close, open} end)
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    lex(str)
    |> valid?()
  end

  defp lex(str) do
    String.graphemes(str)
    |> :string.tokens(@brackets)
    |> case do
      [] -> []
      [tokens] -> tokens
    end
  end

  defp valid?(tokens), do: valid?(tokens, [])

  defp valid?([token | tokens], state) when token in @open_brackets, do: valid?(tokens, [token | state])
  defp valid?([close_token | tokens], [open_token | state]) when close_token in @close_brackets do
    case Map.fetch!(@bracket_map, close_token) == open_token do
      true -> valid?(tokens, state)
      false -> false
    end
  end
  defp valid?([close_token | _tokens], []) when close_token in @close_brackets, do: false
  defp valid?([_token | tokens], state), do: valid?(tokens, state)
  defp valid?([], state), do: state == []
end
