defmodule Day07 do
  def count_ipv7(addresses) do
    addresses
      |> parse_addresses
      |> Enum.filter(&is_valid_ipv7/1)
      |> Enum.count
  end

  defp parse_addresses(addresses) do
    addresses
      |> String.split("\n", trim: true)
  end

  defp is_valid_ipv7(address) do
    address
      |> split_address
      |> verify_parts
  end

  defp split_address(address) do
    codes = String.split(address, ["[", "]"])
    external = Enum.take_every(codes, 2)
    internal = Enum.drop_every(codes, 2)
    %{ external: external, internal: internal }
  end

  defp verify_parts(parsed_address) do
    verify_external(parsed_address[:external]) &&
    verify_internal(parsed_address[:internal])
  end

  defp verify_external(list) do
    Enum.any?(list, &has_abba?/1)
  end

  defp verify_internal(list) do
    Enum.all?(list, &(!has_abba? &1))
  end

  defp has_abba?(string) do
    do_check_for_abba(string, 0)
  end

  defp do_check_for_abba(string, position)
  when byte_size(string) < (position + 4), do: false

  defp do_check_for_abba(string, position) do
    ab = string
      |> String.slice(position, 2)
    ba = string
      |> String.slice(position + 2, 2)
    case ab == String.reverse(ba) && ab != ba do
      true -> true
      false -> do_check_for_abba(string, position + 1)
    end
  end
end
