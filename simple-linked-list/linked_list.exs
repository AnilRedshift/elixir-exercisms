defmodule LinkedList do
  @opaque t :: tuple()

  @tail {:tail}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    @tail
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(@tail, elem), do: {elem, @tail}
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(@tail), do: 0
  def length({_elem, @tail}), do: 1
  def length({_elem, rest}), do: 1 + LinkedList.length(rest)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list), do: LinkedList.length(list) == 0

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(@tail), do: {:error, :empty_list}
  def peek({elem, _rest}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(@tail), do: {:error, :empty_list}
  def tail({_elem, rest}), do: {:ok, rest}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@tail), do: {:error, :empty_list}
  def pop({elem, list}), do: {:ok, elem, list}


  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    Enum.reverse(list)
    |> Enum.reduce(LinkedList.new(), &(push(&2, &1)))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(@tail), do: []
  def to_list({elem, rest}), do: [elem | to_list(rest)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    LinkedList.to_list(list)
    |> Enum.reverse()
    |> LinkedList.from_list()
  end
end
