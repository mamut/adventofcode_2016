defmodule Day05Test do
  use ExUnit.Case

  @tag :skip
  test "finds the password for example case" do
    assert Day05.haxxor("abc") == "18f47a30"
  end
end
