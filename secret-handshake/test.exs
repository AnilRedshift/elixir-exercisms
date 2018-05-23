defmodule Test do
  def hello(name) when name == "foo" do
    IO.puts("bar")
  end

  def hello(name), do: IO.puts("world")
end
