# GithubChecker

check opened PR

# Usage

```ruby
repos = %w|rails/rails git/git|
GithubChecker.check(repos, user: 'account_name', access_token: 'your access_token')
```
or
```ruby
repos = %w|rails/rails git/git|
GithubChecker.check_with_messsage(repos, user: 'account_name', access_token: 'your access_token')
```
