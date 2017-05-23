GithubExercise

This is a sample Elixir application which makes a request to github api and stores data into postgres database



#How to Run

- brew install postgresql
- mix deps.get
- mix ecto.setup
- iex -S mix

#Request Example

- {:ok, pid} = GithubExercise.start_link
- GithubExercise.get_data(pid, "/users")
