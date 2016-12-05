defmodule Day01 do
  def distance(directions_string) do
    do_distance(:up, 0, 0, parse_directions(directions_string))
  end

  defp parse_directions(directions_string) do
    directions_string
      |> String.split(", ", trim: true)
      |> Enum.map(&String.to_charlist/1)
  end

  defp do_distance(_, x, y, []), do: abs(x) + abs(y)

  defp do_distance(dir, x, y, [step | steps]) do
    [turn, move] = parse_step(step)
    new_dir = change_dir(dir, turn)
    case new_dir do
      :up -> do_distance(new_dir, x, y + move, steps)
      :right -> do_distance(new_dir, x + move, y, steps)
      :down -> do_distance(new_dir, x, y - move, steps)
      :left -> do_distance(new_dir, x - move, y, steps)
    end
  end

  def find_intersection(directions_string) do
    do_find_intersection(:up,
                         0,
                         0,
                         MapSet.new,
                         parse_directions(directions_string))
  end

  defp do_find_intersection(_, _, _, _, []), do: nil

  defp do_find_intersection(dir, x, y, coords, [step | steps]) do
    [turn, move] = parse_step(step)
    new_dir = change_dir(dir, turn)
    [new_x, new_y] = case new_dir do
      :up -> [x, y + move]
      :right -> [x + move, y]
      :down -> [x, y - move]
      :left -> [x - move, y]
    end
    [_start | new_coords] = traverse_single_step(x, y, new_x, new_y)
    intersection = Enum.find(new_coords,
                             fn point -> MapSet.member?(coords, point) end)
    case intersection do
      nil ->
        do_find_intersection(new_dir,
                            new_x,
                            new_y,
                            MapSet.union(coords, MapSet.new(new_coords)),
                            steps)
      [x, y] -> abs(x) + abs(y)
    end
  end

  defp traverse_single_step(x, y1, x, y2) do
    Enum.map(y1..y2, fn y -> [x, y] end)
  end

  defp traverse_single_step(x1, y, x2, y) do
    Enum.map(x1..x2, fn x -> [x, y] end)
  end

  defp parse_step(step) do
    [turn_code | move_value] = step
    turn = case turn_code do
      ?L -> :left
      ?R -> :right
    end
    move = List.to_integer(move_value)
    [turn, move]
  end

  defp change_dir(current, :left) do
    case current do
      :up -> :left
      :right -> :up
      :down -> :right
      :left -> :down
    end
  end

  defp change_dir(current, :right) do
    case current do
      :up -> :right
      :right -> :down
      :down -> :left
      :left -> :up
    end
  end
end
