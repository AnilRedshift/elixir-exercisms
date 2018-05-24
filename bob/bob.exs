defmodule Bob do

  @responses %{
    default: "Whatever.",
    shouting: "Whoa, chill out!",
    question: "Sure.",
    shouting_question: "Calm down, I know what I'm doing!",
  }

  def hey(input) do
    cond do
      String.match?(input, ~r/^[^a-z]+\?$/) -> @responses.shouting_question
      String.match?(input, ~r/^[^a-z]+$/) -> @responses.shouting
      String.ends_with?(input, "?") -> @responses.question
      true -> @responses.default
    end
  end
end
