defmodule Day02Test do
  use ExUnit.Case

  test "no instructions, no code" do
    assert Day02.decipher("") == ""
  end

  test "given example" do
    assert Day02.decipher("""
    ULL
    RRDDD
    LURDL
    UUUUD
    """) == "1985"
  end

  test "given example with advanced board" do
    assert Day02.real_decipher("""
    ULL
    RRDDD
    LURDL
    UUUUD
    """) == "5DB3"
  end
end
