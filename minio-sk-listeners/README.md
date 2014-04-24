# Listeners style

Things to note:

1. __Pure Tell-Don't-Ask approach. Application is driven by events. We use controllers as listeners to application events.__

This code is based on _minio-sk-plain-rails_, so also

2. End-to-end tests (feature tests) are written in a way, that you don't know if it's a desktop/web app or even a fancy SPA. This is an indirection, but makes executable specification much more readable.
3. We are using `Guest` class for unauthorized user instead of `user_signed_in?` helper that checks for `nil`.
4. We try to push persistence out of models, so we try to never call `save`, `update` in our models.

