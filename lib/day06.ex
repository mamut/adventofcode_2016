defmodule Day06 do
  def decode(sample) do
    do_decode(sample, &find_most_frequent_occurence/1)
  end

  def least_decode(sample) do
    do_decode(sample, &find_least_frequent_occurence/1)
  end

  defp do_decode(sample, decoder) do
    sample
      |> parse_sample
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(decoder)
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

  defp find_least_frequent_occurence(letters) do
    Enum.min_by(letters, fn letter -> Enum.count(letters, fn x -> letter == x end) end)
  end
end
