defmodule FetcherTest do
  use ExUnit.Case
  alias Fetcher.UserAPI

  test "parses json data into a map" do
    user = File.read!("test/user_data.json")

    parsed = UserAPI.parse_json_to_map(user)

    assert is_map(parsed)

    name = Map.get(parsed, "name")
    assert name == "Leanne Graham"
  end
end
