defmodule Day01Test do
  use ExUnit.Case

  test "empty list" do
    assert Day01.distance([]) == 0
  end

  test "R2 L3" do
    assert Day01.distance(['R2', 'L3']) == 5
  end

  test "R2 R2 R2" do
    assert Day01.distance(['R2', 'R2', 'R2']) == 2
  end

  test "R5 L5 R5 R3" do
    assert Day01.distance(['R5', 'L5', 'R5', 'R3']) == 12
  end
end
