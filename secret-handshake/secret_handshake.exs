defmodule SecretHandshake do
  require IEx
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  def commands(code) when (code &&& 0b10000) != 0 do
    mask = ~~~0b10000
    commands(code &&& mask)
    |> Enum.reverse
  end

  %{
    0b1 => "wink",
    0b10 => "double blink",
    0b100 => "close your eyes",
    0b1000 => "jump",
  }
  |> Enum.each(fn ({num, command}) ->
    def commands(code) when (code &&& unquote(num)) != 0 do
      mask = ~~~unquote(num)
      rest = commands(code &&& mask)
      [unquote(command) | rest]
    end
  end)

  def commands(_code), do: []
end
