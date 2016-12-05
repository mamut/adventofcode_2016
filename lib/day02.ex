defmodule Day02 do
  def decipher(instructions) do
    do_decipher(5, [], parse_instructions(instructions), &next_digit/2)
  end

  defp parse_instructions(instructions) do
    String.split(instructions)
  end

  defp do_decipher(_, digits, [], _), do: Enum.join(Enum.reverse(digits))

  defp do_decipher(pos, digits, [instruction | instructions], adv_func) do
    digit = find_digit(pos, String.codepoints(instruction), adv_func)
    do_decipher(digit, [digit | digits], instructions, adv_func)
  end

  defp find_digit(pos, [], _), do: pos

  defp find_digit(pos, [dir | instruction], adv_func) do
    current = adv_func.(pos, dir)
    find_digit(current, instruction, adv_func)
  end

  defp next_digit(pos, dir) do
    point = pos_to_point(pos)
    advanced_point = advance(point, dir)
    point_to_pos(advanced_point)
  end

  defp pos_to_point(pos) do
    x = rem(pos + 2, 3)
    y = div(pos - 1, 3)
    [x, y]
  end

  def point_to_pos([x, y]), do: y * 3 + (x + 1)

  defp advance([x, y], "U"), do: cutoff([x, y - 1])
  defp advance([x, y], "R"), do: cutoff([x + 1, y])
  defp advance([x, y], "D"), do: cutoff([x, y + 1])
  defp advance([x, y], "L"), do: cutoff([x - 1, y])

  defp cutoff([x, y]) when x < 0, do: cutoff([0, y])
  defp cutoff([x, y]) when x > 2, do: cutoff([2, y])
  defp cutoff([x, y]) when y < 0, do: cutoff([x, 0])
  defp cutoff([x, y]) when y > 2, do: cutoff([x, 2])
  defp cutoff(point), do: point

  def real_decipher(instructions) do
    do_decipher("5", [], parse_instructions(instructions), &next_key/2)
  end

  def next_key(pos, dir) do
    point = boardmap
            |> Enum.find(fn { _, key } -> pos == key end)
            |> elem(0)
    new_point = real_advance(point, dir)
    case Map.fetch(boardmap, new_point) do
      { :ok, new_pos } -> new_pos
      :error -> pos
    end
  end

  defp real_advance([x, y], "U"), do: [x, y - 1]
  defp real_advance([x, y], "R"), do: [x + 1, y]
  defp real_advance([x, y], "D"), do: [x, y + 1]
  defp real_advance([x, y], "L"), do: [x - 1, y]

  def boardmap do
    #     1
    #   2 3 4
    # 5 6 7 8 9
    #   A B C
    #     D

    %{
      [2, 0] =>  "1",
      [1, 1] =>  "2", [2, 1] =>  "3", [3, 1] =>  "4",
      [0, 2] =>  "5", [1, 2] =>  "6", [2, 2] =>  "7", [3, 2] =>  "8", [4, 2] =>  "9",
      [1, 3] =>  "A", [2, 3] =>  "B", [3, 3] =>  "C",
      [2, 4] =>  "D",
    }
  end
end
