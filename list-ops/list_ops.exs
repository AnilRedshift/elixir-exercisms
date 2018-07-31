defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn _item, sum -> sum + 1 end)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: reduce(l, [], &[f.(&1) | &2]) |> reverse()

  def filter(l, f), do: reduce(l, [], fn item, acc ->
    case !!f.(item) do
      true -> [item | acc]
      false -> acc
    end
  end)
  |> reverse()

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([first | rest], acc, f) do
    acc = f.(first, acc)
    reduce(rest, acc, f)
  end

  def append(a, b), do: reverse(a) |> reduce(b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], fn (l, acc) ->
      reduce(l, acc, &[&1 | &2])
    end)
    |> reverse()
  end
end
