defmodule Bob do

  @responses %{
    default: "Whatever.",
    shouting: "Whoa, chill out!",
    question: "Sure.",
    shouting_question: "Calm down, I know what I'm doing!",
    silence: "Fine. Be that way!",
  }

  def hey(input) do
    cond do
      String.match?(input, ~r/^\s*$/) -> @responses.silence
      shouting(input) and String.ends_with?(input, "?") -> @responses.shouting_question
      shouting(input) -> @responses.shouting
      String.ends_with?(input, "?") -> @responses.question
      true -> @responses.default
    end
  end

  defp shouting(input), do: String.upcase(input) == input and String.downcase(input) != input
end
