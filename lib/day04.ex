defmodule Day04 do
  def sum_valid_sector_ids(codes) do
    parse_codes(codes)
      |> Enum.filter(&valid_checksum/1)
      |> Enum.reduce(0, fn [_, sector_id, _], acc -> sector_id + acc end)
  end

  def decipher_room_codes(codes) do
    parse_codes(codes)
      |> Enum.filter(&valid_checksum/1)
      |> Enum.map(&decipher_room_code/1)
  end

  defp decipher_room_code([chars, sector_id, _]) do
    deciphered = chars
      |> String.to_charlist
      |> Enum.map(fn code ->
        case code do
          ?- -> ?\s
          x -> rotate(x, sector_id)
        end
      end)
      |> List.to_string
    [deciphered, sector_id]
  end

  defp rotate(char, shift) do
    initial_shift = char - ?a
    new_shift = rem(initial_shift + shift, ?z - ?a + 1)
    new_shift + ?a
  end

  defp parse_codes(codes) do
    codes
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_code/1)
  end

  defp valid_checksum([chars, _, checksum]), do: get_checksum(chars) == checksum

  defp parse_code(code) do
    regexp = ~r/(?<chars>[a-z-]+)-(?<sector_id>\d+)\[(?<checksum>[a-z]+)\]/
    captures = Regex.named_captures(regexp, code)
    convert_captures(captures)
  end

  defp convert_captures(%{
    "chars" => chars,
    "sector_id" => sector_id,
    "checksum" => checksum }) do
        [chars, String.to_integer(sector_id), checksum]
  end

  defp get_checksum(chars) do
    frequency = chars
      |> String.codepoints
      |> Enum.filter(fn c -> c != "-" end)
      |> Enum.group_by(fn x -> x end)
      |> Enum.map(fn { key, value } -> { key, length(value) } end)
      |> Map.new
    letters = Map.keys(frequency)
    Enum.sort(letters, fn c1, c2 ->
      freq1 = Map.get(frequency, c1)
      freq2 = Map.get(frequency, c2)
      case freq1 == freq2 do
        false -> freq1 > freq2
        true -> c1 <= c2
      end
    end)
      |> Enum.take(5)
      |> Enum.join
  end
end
