defmodule Day03 do
  def count_triangles(specifications) do
    parse_specifications(specifications)
      |> Enum.filter(&is_triangle/1)
      |> length
  end

  defp parse_specifications(specifications) do
    specifications
      |> String.split("\n", trim: true)
      |> Enum.map(&split_and_parse/1)
  end

  defp split_and_parse(specification) do
    specification
      |> String.split
      |> Enum.map(&String.to_integer/1)
  end

  defp is_triangle([a, b, c]) do
    (a + b) > c && (a + c) > b && (b + c) > a
  end

  def count_vertical_triangles(specifications) do
    parse_vertical_specifications(specifications)
      |> Enum.filter(&is_triangle/1)
      |> length
  end

  defp parse_vertical_specifications(specifications) do
    specifications
      |> String.split
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index
      |> Enum.group_by(fn { _x, idx } -> rem(idx, 3) end, fn { x, _idx } -> x end)
      |> Map.values
      |> List.flatten
      |> Enum.chunk(3)
  end
end
