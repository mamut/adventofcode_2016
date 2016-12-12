defmodule Day06Test do
  use ExUnit.Case

  test "decode the most frequent letters" do
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

  test "decode the lease frequent letters" do
    assert Day06.least_decode("""
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
    """) == "advent"
  end
end
