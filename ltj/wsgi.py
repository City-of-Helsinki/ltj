"""
WSGI config for ltj project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.9/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ltj.settings")


class ForwardedPrefixWSGIMiddleware:
    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        prefix = environ.get("HTTP_X_FORWARDED_PREFIX", "")

        if prefix:
            prefix = "/" + prefix.strip("/")
            environ["SCRIPT_NAME"] = prefix

        return self.app(environ, start_response)


application = ForwardedPrefixWSGIMiddleware(get_wsgi_application())
