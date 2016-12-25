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

  test "case 1b" do
    assert Day07.count_ipv7s("aba[bab]xyz") == 1
  end

  test "case 2b" do
    assert Day07.count_ipv7s("xyx[xyx]xyx") == 0
  end

  test "case 3b" do
    assert Day07.count_ipv7s("aaa[kek]eke") == 1
  end

  test "case 4b" do
    assert Day07.count_ipv7s("zazbz[bzb]cdb") == 1
  end

  test "total for second part" do
    assert Day07.count_ipv7s("""
    aba[bab]xyz
    xyx[xyx]xyx
    aaa[kek]eke
    zazbz[bzb]cdb
    """) == 3
  end
end
