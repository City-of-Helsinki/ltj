import logging
from django.urls import set_script_prefix

logger = logging.getLogger(__name__)

class PathPrefixMiddleware:
  def __init__(self, get_response):
    self.get_response = get_response

  def __call__(self, request):
    script_prefix = request.headers.get('X-Forwarded-Prefix', None)
    if script_prefix:
      set_script_prefix(script_prefix)