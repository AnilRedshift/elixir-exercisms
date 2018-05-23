defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()

  def rotate(text, shift) when shift >= 26, do: rotate(text, rem(shift, 26))
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(&rotate_char(&1, shift: shift))
    |> List.to_string
  end

  defp rotate_char(c, shift: shift) when c in (?A..?Z), do: rotate_char(c, shift: shift, begin: ?A, end: ?Z)
  defp rotate_char(c, shift: shift) when c in (?a..?z), do: rotate_char(c, shift: shift, begin: ?a, end: ?z)
  defp rotate_char(c, shift: _), do: c
  defp rotate_char(c, shift: shift, begin: begin, end: e) do
    range = (e - begin) + 1
    begin + rem(c + shift - begin, range)
  end
end
