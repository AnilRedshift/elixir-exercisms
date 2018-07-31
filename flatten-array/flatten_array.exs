defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list), do: do_flatten(list) |> Enum.reverse()
  def do_flatten(list) do
    Enum.reduce(list, [], fn
      [], acc -> acc
      nil, acc -> acc
      item, acc when is_list(item) -> do_flatten(item) ++ acc
      item, acc -> [item | acc]
    end)
  end
end
