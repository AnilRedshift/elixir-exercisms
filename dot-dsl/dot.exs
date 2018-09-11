defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(ast) do
    {_, output} = Macro.prewalk(ast, %Graph{}, &convert/2)

    quote do
      unquote(Macro.escape(output))
    end
  end

  defp convert({name, context, nil}, graph) do
    convert({name, context, [[]]}, graph)
  end
  defp convert({name, context, [args]}=node, graph) do
    graph = update_in(graph, [Access.key(:nodes)], &[{name, args} | &1])
    {node, graph}
  end

  defp convert(node, graph) do
    {node, graph}
  end
end
