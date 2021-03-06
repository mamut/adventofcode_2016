defmodule Day07 do
  def count_ipv7(addresses) do
    addresses
      |> parse_addresses
      |> Enum.filter(&is_valid_ipv7/1)
      |> Enum.count
  end

  def count_ipv7s(addresses) do
    addresses
      |> parse_addresses
      |> Enum.filter(&has_ssl?/1)
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

  defp has_ssl?(address) do
    address
      |> split_address
      |> verify_ssl
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

  defp verify_ssl(address) do
    external_triplets = extract_triplets(address[:external])
    internal_triplets = extract_triplets(address[:internal])
    has_matching_triplets?(external_triplets, internal_triplets)
  end

  defp extract_triplets(parts) do
    parts
      |> Enum.map(&collect_triplets/1)
      |> List.flatten
  end

  defp collect_triplets(string) do
    do_collect_triplets(string, 0, [])
  end

  defp do_collect_triplets(string, position, agg)
  when byte_size(string) < (position + 3), do: agg

  defp do_collect_triplets(string, position, agg) do
    a1 = String.at(string, position)
    b = String.at(string, position + 1)
    a2 = String.at(string, position + 2)

    if (a1 == a2) && (a1 != b) do
      triplet = String.slice(string, position, 2)
      do_collect_triplets(string, position + 1, [triplet | agg])
    else
      do_collect_triplets(string, position + 1, agg)
    end
  end

  defp has_matching_triplets?(external, internal) do
    inverse_internal = inverse_triplets(internal)
    !MapSet.disjoint?(MapSet.new(external), MapSet.new(inverse_internal))
  end

  defp inverse_triplets(triplets) do
    triplets
      |> Enum.map(&String.reverse/1)
  end
end
