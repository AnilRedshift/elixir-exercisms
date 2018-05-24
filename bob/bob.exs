defmodule Bob do

  @responses %{
    default: "Whatever.",
    shouting: "Whoa, chill out!",
  }

  def hey(input) do
    cond do
      String.match?(input, ~r/^[^a-z]+$/) -> @responses.shouting
      true -> @responses.default
    end
  end
end
