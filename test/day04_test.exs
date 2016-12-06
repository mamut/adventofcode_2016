defmodule Day04Test do
  use ExUnit.Case

  test "returns 0 for no codes" do
    assert Day04.sum_valid_sector_ids("") == 0
  end

  test "doesn't add up invalid sector ids" do
    assert Day04.sum_valid_sector_ids("""
    totally-real-room-200[decoy]
    """) == 0
  end

  test "adds up valid sector ids" do
    assert Day04.sum_valid_sector_ids("""
    aaaaa-bbb-z-y-x-123[abxyz]
    """) == 123
  end

  test "sums up sector ids" do
    assert Day04.sum_valid_sector_ids("""
    aaaaa-bbb-z-y-x-123[abxyz]
    a-b-c-d-e-f-g-h-987[abcde]
    not-a-real-room-404[oarel]
    totally-real-room-200[decoy]
    """) == 1514
  end
end
