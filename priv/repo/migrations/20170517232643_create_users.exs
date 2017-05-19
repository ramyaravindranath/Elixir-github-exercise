defmodule Users.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do

  	create table(:users) do
  		add :login, :string
  		add :repos_url, :string
  	end
  	
  end
end
