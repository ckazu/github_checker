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

[![Dependency Status](https://gemnasium.com/ckazu/github_checker.png)](https://gemnasium.com/ckazu/github_checker)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/ckazu/github_checker/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
