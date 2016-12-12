defmodule Day06 do
  def decode(sample) do
    sample
      |> parse_sample
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&find_most_frequent_occurence/1)
      |> Enum.join
  end

  defp parse_sample(sample) do
    sample
      |> String.split("\n", trim: true)
      |> Enum.map(fn word -> String.graphemes(word) end)
  end

  defp find_most_frequent_occurence(letters) do
    Enum.max_by(letters, fn letter -> Enum.count(letters, fn x -> letter == x end) end)
  end
end
