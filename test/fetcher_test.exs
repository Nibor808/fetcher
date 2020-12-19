defmodule FetcherTest do
  use ExUnit.Case
  alias Fetcher.UserAPI

  test "parses json data into a map" do
    user = get_json()
    parsed = Fetcher.UserAPI.parse_json_to_map(user)

    assert is_map(parsed)

    name = Map.get(parsed, "name")
    assert name == "Leanne Graham"
  end

  def get_json do
    with {:ok, body} <- File.read!("test/user_data.json"),
         {:ok, json} <- Poison.decode!(body),
         do: {:ok, json}
  end
end
