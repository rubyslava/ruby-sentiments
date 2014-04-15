# Events

I was trying to create minimal code to implement all functionality from the
[specification](../../../../#specification-1).

## Used technologies

All my technology decisions are based on time constraints. Actually I spent more
time (2 hours) on this that I originally wanted, because I was stuck with cookies.

* Rails - I would like to try http://lotusrb.org/, but I am much more productive
  with rails.
* RSpec - Same here. I would like to learn minitest. But not now.
* Controller tests - I wrote them to make future refactoring easier.
* Cookies - I store "registration" data in cookies. Just because it is enough to
  implement required functionality.

## Usage

```
git clone git@github.com:rubyslava/ruby-sentiments.git
cd patrik-bona/events
bundle
rake db:seed
rails s
```
