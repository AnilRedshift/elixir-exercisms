defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  def count([], sum), do: sum
  def count([_item | rest], sum), do: count(rest, sum + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], fn (item, reversed) -> [item | reversed] end)

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([first | rest], f), do: [f.(first) | map(rest, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: filter(l, f, []) |> reverse()
  def filter([], _f, res), do: res
  def filter([first | rest], f, res) do
    res = case !!f.(first) do
      true -> [first | res]
      false -> res
    end
    filter(rest, f, res)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([first | rest], acc, f) do
    acc = f.(first, acc)
    reduce(rest, acc, f)
  end

  def append(a, b) do
    reverse(a)
    |> reduce(b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], fn (l, acc) ->
      reduce(l, acc, &[&1 | &2])
    end)
    |> reverse()
  end
end
