defmodule Day01Test do
  use ExUnit.Case

  test "distance for empty list" do
    assert Day01.distance("") == 0
  end

  test "distance for R2 L3" do
    assert Day01.distance("R2, L3") == 5
  end

  test "distance for R2 R2 R2" do
    assert Day01.distance("R2, R2, R2") == 2
  end

  test "distance for R5 L5 R5 R3" do
    assert Day01.distance("R5, L5, R5, R3") == 12
  end

  test "find_intersection for empty list" do
    assert Day01.find_intersection("") == nil
  end

  test "find_intersection for R8 R4 R4 R8" do
    assert Day01.find_intersection("R8, R4, R4, R8") == 4
  end
end
