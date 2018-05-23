defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) when is_binary(phrase) do
    phrase
    |> String.to_charlist()
    |> translate()
    |> List.to_string()
  end
  def translate([]), do: []
  def translate([first | _] = word) when first in [?a, ?A, ?e, ?E, ?i, ?I, ?o, ?O, ?u, ?U] do
    word ++ 'ay'
  end
  def translate([first | rest]), do: rest ++ [first ] ++ 'ay'
end
