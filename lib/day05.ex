defmodule Day05 do
  def haxxor(code) do
    do_haxxor(code, 0, [])
  end

  def phreak(code) do
    do_phreak(code, 0, %{})
  end

  defp do_haxxor(_, _, found) when length(found) == 8 do
    found
      |> Enum.reverse
      |> Enum.join
  end

  defp do_haxxor(code, idx, found) do
    case check_idx(code, idx) do
      { :ok, letter } -> do_haxxor(code, idx + 1, [letter | found])
      _ -> do_haxxor(code, idx + 1, found)
    end
  end

  defp do_phreak(_, _, found) when map_size(found) == 8 do
    (0..7)
      |> Enum.map(fn idx -> Map.get(found, idx) end)
      |> Enum.join
  end

  defp do_phreak(code, idx, found) do
    case check_idx_and_pos(code, idx) do
      { :ok, letter, pos } -> do_phreak(code, idx + 1, Map.put_new(found, pos, letter))
      :not_found -> do_phreak(code, idx + 1, found)
    end
  end

  defp check_idx(code, idx) do
    hash = md5(code, idx)
    case String.starts_with?(hash, "00000") do
      true -> { :ok, String.at(hash, 5) }
      false -> :not_found
    end
  end

  defp check_idx_and_pos(code, idx) do
    case parse_hash(md5(code, idx)) do
      [pos, digit] when pos < 8  -> { :ok, digit, pos }
      _ -> :not_found
    end
  end

  defp parse_hash(hash) do
    case hash do
      "00000" <> <<pos::bytes-size(1)>> <> <<digit::bytes-size(1)>> <> _ ->
        [String.to_integer(pos, 16), digit]
      _ -> :not_found
    end
  end

  defp md5(code, idx) do
    :crypto.hash(:md5, "#{ code }#{ idx }")
      |> Base.encode16
      |> String.downcase
  end
end
