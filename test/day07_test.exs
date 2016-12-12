defmodule Day07Test do
  use ExUnit.Case

  test "case 1" do
    assert Day07.count_ipv7("abba[mnop]qrst") == 1
  end

  test "case 2" do
    assert Day07.count_ipv7("abcd[bddb]xyyx") == 0
  end

  test "case 3" do
    assert Day07.count_ipv7("aaaa[qwer]tyui") == 0
  end

  test "case 4" do
    assert Day07.count_ipv7("ioxxoj[asdfgh]zxcvbn") == 1
  end

  test "total" do
    assert Day07.count_ipv7("""
    abba[mnop]qrst
    abcd[bddb]xyyx
    aaaa[qwer]tyui
    ioxxoj[asdfgh]zxcvbn
    """) == 2
  end
end
