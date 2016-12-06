defmodule Day05 do
  def haxxor(code) do
    do_haxxor(code, 0, [])
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

  defp check_idx(code, idx) do
    hash = md5(code, idx)
    case String.starts_with?(hash, "00000") do
      true -> { :ok, String.at(hash, 5) }
      false -> :not_found
    end
  end

  defp md5(code, idx) do
    :crypto.hash(:md5, "#{ code }#{ idx }")
      |> Base.encode16
      |> String.downcase
  end
end
