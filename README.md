# Fetcher

**A simple GenServer setup for fetching json data from [jsonpalceholder](http://jsonplaceholder.typicode.com)**

### Modules - Methods

#### User

- users()<br>
- user(id :integer)

_start an iex session:_

`iex -S mix`

_then:_

`iex(1)> Fetcher.UserAPI.users()`

`iex(2)> Fetcher.UserAPI.user(1)`
