defmodule Day06Test do
  use ExUnit.Case

  test "finds the more 1337 password too" do
    assert Day06.decode("""
    eedadn
    drvtee
    eandsr
    raavrd
    atevrs
    tsrnev
    sdttsa
    rasrtv
    nssdts
    ntnada
    svetve
    tesnvt
    vntsnd
    vrdear
    dvrsen
    enarar
    """) == "easter"
  end
end
