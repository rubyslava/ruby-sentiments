# Vanilla rails app

This is the most classic rails-way of building a web app.

Things to note:

1. End-to-end tests (feature tests) are written in a way, that you don't know if it's a desktop/web app or even a fancy SPA. This is an indirection, but makes executable specification much more readable.
2. We are using `Guest` class for unauthorized user instead of `user_signed_in?` helper that checks for `nil`.
3. We try to push persistence out of models, so we try to never call `save`, `update` in our models.
