defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(ast) do
    Macro.prewalk(ast, nil, fn
      {:., _, _}, _ -> raise ArgumentError
      node, context -> {node, context}
    end)
    {_, output} = Macro.prewalk(ast, %Graph{}, &convert/2)

    quote do
      unquote(Macro.escape(output))
    end
  end

  defp convert({:--, _context, [{start_node, _, _}, {end_node, _, args}]}, graph) do
    [args] = args || [[]]
    edge = {start_node, end_node, args}
    graph = append(graph, :edges, [edge])
    {{}, graph}
    {{}, graph}
  end

  defp convert({:graph, _context, [args]}, graph) do
    graph = append(graph, :attrs, args)
    {{}, graph}
  end

  defp convert({name, context, nil}, graph) do
    convert({name, context, [[]]}, graph)
  end

  defp convert({name, _context, [args]}, graph) do
    if not Keyword.keyword?(args), do: raise ArgumentError
    graph = append(graph, :nodes, [{name, args}])
    {{}, graph}
  end

  defp convert([{:do, _}]=node, graph) do
    {node, graph}
  end

  defp convert({:do, _}=node, graph) do
    {node, graph}
  end

  defp convert(:do, graph), do: {:do, graph}
  defp convert({:__block__, _context, _args}=node, graph) do
    {node, graph}
  end

  defp convert(node, _graph) do
    raise ArgumentError
  end

  defp append(graph, key, args) do
    update_in(graph, [Access.key(key)], &Enum.sort(&1 ++ args))
  end
end
