defmodule Day02 do
  def decipher(instructions) do
    do_decipher(5, [], parse_instructions(instructions))
  end

  defp parse_instructions(instructions) do
    String.split(instructions)
  end

  defp do_decipher(_, digits, []), do: Enum.join(Enum.reverse(digits))

  defp do_decipher(pos, digits, [instruction | instructions]) do
    digit = find_digit(pos, String.codepoints(instruction))
    do_decipher(digit, [digit | digits], instructions)
  end

  defp find_digit(pos, []), do: pos

  defp find_digit(pos, [dir | instruction]) do
    current = next_digit(pos, dir)
    find_digit(current, instruction)
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
end
