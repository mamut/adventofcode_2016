defmodule Day03Test do
  use ExUnit.Case

  test "no specifications, no triangles" do
    assert Day03.count_triangles("") == 0
  end

  test "it counts a valid triangle" do
    assert Day03.count_triangles("""
    5 5 5
    """) == 1
  end

  test "it rejects an invalid triangle" do
    assert Day03.count_triangles("""
    5 10 25
    """) == 0
  end

  test "it accepts multiple specifications" do
    assert Day03.count_triangles("""
    3 4 5
    5 5 5
    5 10 25
    """) == 2
  end

  test "it can count triangles vertically" do
    assert Day03.count_vertical_triangles("""
    3 4 5
    5 5 5
    5 10 25
    """) == 1
  end

  test "it can count triangles stacked vertically" do
    assert Day03.count_vertical_triangles("""
    3 4 5
    5 5 5
    5 10 25
    8 1 5
    9 1 35
    9 10 25
    """) == 2
  end
end
