defmodule Day05Test do
  use ExUnit.Case

  @tag :skip
  test "finds the password for example case" do
    assert Day05.haxxor("abc") == "18f47a30"
  end

  @tag :skip
  @tag timeout: 120000
  test "finds the more 1337 password too" do
    assert Day05.phreak("abc") == "05ace8e3"
  end
end
