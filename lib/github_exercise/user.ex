defmodule GithubExercise.User do
  use Ecto.Schema

  schema "users" do
    field :login, :string
    field :repos_url, :string
  end

end