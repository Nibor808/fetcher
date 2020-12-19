defmodule Fetcher.UserAPI do
  @moduledoc """
  Fetch fake user data from jsonplaceholder.typicode.com
  """

  use GenServer

  @root_url "http://jsonplaceholder.typicode.com/users"
  @name :fetcher_user_api

  # CLIENT INTERFEACE

  def start_link(_args) do
    IO.puts("Starting the User API...")
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  @doc """
  Fetch all users
  """
  def users do
    GenServer.call(@name, :users)
  end

  @doc """
  Fetch a user by id
  """
  def user(id) when is_integer(id) do
    GenServer.call(@name, {:user, id})
  end

  # SERVER CALLBACKS

  def init(args) do
    {:ok, args}
  end

  def handle_call(:users, _from, state) do
    HTTPoison.get(@root_url)
    |> handle_response(state)
  end

  def handle_call({:user, id}, _from, state) do
    HTTPoison.get("#{@root_url}/#{id}")
    |> handle_response(state)
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, state) do
    parsed = Poison.Parser.parse!(body, %{})
    {:reply, parsed, state}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 404} = response}, state) do
    {:reply, "Path: #{response.request_url} not found.", state}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}, state) do
    IO.puts("Error fetching: #{inspect(reason)}")
    {:reply, state}
  end
end
