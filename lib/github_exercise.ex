defmodule GithubExercise do

  use GenServer
  use HTTPoison.Base
  

  @moduledoc """
  Documentation for GithubExercise.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GithubExercise.hello
      :world

  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init() do
    {:ok, %{}}
  end

  def get_data(pid, resource) do
    GenServer.call(pid, {:data, resource})
  end

  def handle_call({:data, resource}, _from, state) do
    response = 
    HTTPoison.get!("https://api.github.com" <> resource)
    |> handle_http_error(resource)
    |> Map.fetch!(:body)
    |> Poison.decode!
    |> store_data

    {:reply, response, state}    
  end

  defp handle_http_error(response = %{status_code: status_code}, _path) when status_code == 200 do
    response
  end

  defp handle_http_error(response, path) do
    message = """
    Failed to connect to API.
      URI: #{path}
      Response code: #{response.status_code}
    """
  end

  defp store_data([%{"login" => login, "repos_url" => repo_url} | tail]) do
    user = %GithubExercise.User{login: login, repos_url: repo_url}
    Users.Repo.insert(user)
    store_data(tail)
  end

  defp store_data([]) do
    :ok
  end
  
end


