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
  @consonant "[b-df-hj-np-tv-z]"
  @xy_re Regex.compile("^[xy]#{@consonant}", "i") |> elem(1)
  @re Regex.compile("^(?:#{@consonant}?qu)|#{@consonant}*", "i") |> elem(1)
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end

  defp translate_word(phrase) do
    if (String.match?(phrase, @xy_re)), do: translate_xy(phrase), else: translate_normal(phrase)
  end

  defp translate_xy(phrase), do: phrase <> "ay"
  defp translate_normal(phrase) do
    case Regex.run(@re, phrase) do
      [prefix] -> String.replace_prefix(phrase, prefix, "") <> prefix <> "ay"
      _ -> phrase <> "ay"
    end
  end
end
