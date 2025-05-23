import os
import environ
import subprocess

SOCIAL_AUTH_PIPELINE = (
    # Get the information we can about the user and return it in a simple
    # format to create the user instance later. On some cases the details are
    # already part of the auth response from the provider, but sometimes this
    # could hit a provider API.
    "social_core.pipeline.social_auth.social_details",
    # Get the social uid from whichever service we're authing thru. The uid is
    # the unique identifier of the given user in the provider.
    "social_core.pipeline.social_auth.social_uid",
    # Ensure the UID is in UUID format and reformat it, if not.
    "helusers.pipeline.ensure_uid_is_uuid",
    # Reset logged-in user if UUID differs
    "helusers.pipeline.ensure_uuid_match",
    # Generate username from UUID
    "helusers.pipeline.get_username",
    # Checks if the current social-account is already associated in the site.
    "social_core.pipeline.social_auth.social_user",
    # Get or create the user and update user data
    "helusers.pipeline.create_or_update_user",
    # Create the record that associated the social account with this user.
    "social_core.pipeline.social_auth.associate_user",
    # Populate the extra_data field in the social record with the values
    # specified by settings (and the default ones like access_token, etc).
    "social_core.pipeline.social_auth.load_extra_data",
)

root = environ.Path(__file__) - 2
BASE_DIR = root()


def get_git_revision_hash():
    """
    We need a way to retrieve git revision hash for sentry reports
    I assume that if we have a git repository available we will
    have git-the-comamand as well
    """
    try:
        # We are not interested in gits complaints (stderr > /dev/null)
        git_hash = subprocess.check_output(
            ["git", "rev-parse", "HEAD"], stderr=subprocess.DEVNULL, encoding="utf8"
        )
    # ie. "git" was not found
    # should we return a more generic meta hash here?
    # like "undefined"?
    except FileNotFoundError:
        git_hash = "git_not_available"
    except subprocess.CalledProcessError:
        # Ditto
        git_hash = "no_repository"
    return git_hash.rstrip()


env = environ.Env(
    DEBUG=(bool, False),
    SECRET_KEY=(str, ""),
    SHARED_SECRET=(str, ""),
    ALLOWED_HOSTS=(list, []),
    ADMINS=(list, []),
    DATABASE_URL=(str, "postgis:///ltj"),
    MEDIA_ROOT=(environ.Path(), root("media")),
    STATIC_ROOT=(environ.Path(), root("static")),
    MEDIA_URL=(str, "/media/"),
    STATIC_URL=(str, "/static/"),
    LOG_LEVEL=(str, "INFO"),
    SENTRY_DSN=(str, ""),
    SENTRY_ENVIRONMENT=(str, "unconfigured"),
    WFS_SERVER_URL=(str, "https://kartta.hel.fi/ws/geoserver/avoindata/wfs"),
    WFS_NAMESPACE=(str, "avoindata"),
    OIDC_AUDIENCE=(str, ""),
    OIDC_API_SCOPE_PREFIX=(str, ""),
    OIDC_REQUIRE_API_SCOPE_FOR_AUTHENTICATION=(bool, False),
    OIDC_ISSUER=(str, ""),
    SOCIAL_AUTH_TUNNISTAMO_KEY=(str, ""),
    SOCIAL_AUTH_TUNNISTAMO_SECRET=(str, ""),
    SOCIAL_AUTH_TUNNISTAMO_OIDC_ENDPOINT=(str, ""),
)

# .env file, should load only in development environment
DISABLE_CONFIG_FILES = env.bool("DJANGO_DISABLE_CONFIG_FILES", default=False)
if not DISABLE_CONFIG_FILES:
    env_file = root("config.env")
    env.read_env(env_file)

SECRET_KEY = env("SECRET_KEY")
SHARED_SECRET = env("SHARED_SECRET")
DEBUG = env("DEBUG")
ALLOWED_HOSTS = env("ALLOWED_HOSTS")
ADMINS = env("ADMINS")

STATIC_URL = env("STATIC_URL")
MEDIA_URL = env("MEDIA_URL")
STATIC_ROOT = env("STATIC_ROOT")
MEDIA_ROOT = env("MEDIA_ROOT")

# This governs the number of fields allowed in form submissions, including
# the admin site. LTJ has admin pages that upload well over 2000 fields.
# This settings might be the one to tweak if submitting an admin page causes
# a 400 response.
DATA_UPLOAD_MAX_NUMBER_FIELDS = 5000

# log to stderr, at level specified by LOG_LEVEL and add metadata
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "metadata": {
            "format": "%(asctime)s %(levelname)s %(module)s: %(message)s",
        },
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "formatter": "metadata",
            "level": env("LOG_LEVEL"),
        },
    },
    "root": {
        "handlers": ["console"],
        "level": env("LOG_LEVEL"),
    },
}

# Application definition

INSTALLED_APPS = [
    "helusers.apps.HelusersConfig",
    "helusers.apps.HelusersAdminConfig",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "django.contrib.gis",
    "social_django",
    "rest_framework",
    "rest_framework_gis",
    "axes",
    "nature",
    "imports",
    "files",
    "users",
    "hmac_auth",
    "tinymce"
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "django.middleware.locale.LocaleMiddleware",
    "axes.middleware.AxesMiddleware",
]

ROOT_URLCONF = "ltj.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [root("templates")],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "ltj.wsgi.application"

REST_FRAMEWORK = {
    "DEFAULT_PAGINATION_CLASS": "rest_framework.pagination.PageNumberPagination",
    "PAGE_SIZE": 10,
    "DEFAULT_AUTHENTICATION_CLASSES": ("helusers.oidc.ApiTokenAuthentication",),
}

DATABASES = {
    "default": env.db(),
}

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]

LANGUAGE_CODE = "fi"

LOCALE_PATHS = (os.path.join(BASE_DIR, "locale"),)

TIME_ZONE = "Europe/Helsinki"

USE_I18N = True

USE_TZ = True

# Authentication & Authorization
AUTH_USER_MODEL = "users.User"
AUTHENTICATION_BACKENDS = (
    "axes.backends.AxesBackend",
    "helusers.tunnistamo_oidc.TunnistamoOIDCAuth",
    "django.contrib.auth.backends.ModelBackend",
)

LOGIN_REDIRECT_URL = "/"
LOGOUT_REDIRECT_URL = "/"

SESSION_SERIALIZER = "django.contrib.sessions.serializers.JSONSerializer"

OIDC_API_TOKEN_AUTH = {
    "AUDIENCE": env("OIDC_AUDIENCE"),
    "API_SCOPE_PREFIX": env("OIDC_API_SCOPE_PREFIX"),
    "REQUIRE_API_SCOPE_FOR_AUTHENTICATION": env(
        "OIDC_REQUIRE_API_SCOPE_FOR_AUTHENTICATION"
    ),
    "ISSUER": env("OIDC_ISSUER"),
}

SOCIAL_AUTH_TUNNISTAMO_KEY = env("SOCIAL_AUTH_TUNNISTAMO_KEY")
SOCIAL_AUTH_TUNNISTAMO_SECRET = env("SOCIAL_AUTH_TUNNISTAMO_SECRET")
SOCIAL_AUTH_TUNNISTAMO_OIDC_ENDPOINT = env("SOCIAL_AUTH_TUNNISTAMO_OIDC_ENDPOINT")
# Scopes in addition to default OIDC scopes
# "ad_groups" requests user AD groups
SOCIAL_AUTH_TUNNISTAMO_SCOPE = ["ad_groups"]

# Custom settings

SRID = 3879  # Spatial reference system identifier used for geometry fields

WFS_SERVER_URL = env("WFS_SERVER_URL")  # WFS server url for features
WFS_NAMESPACE = env("WFS_NAMESPACE")  # Namespace for WFS layers

DEFAULT_AUTO_FIELD='django.db.models.AutoField'

TINYMCE_JS_URL = os.path.join(STATIC_URL, "tinymce/tinymce.min.js")

TINYMCE_DEFAULT_CONFIG = {
    "height": "500px",
    "menubar": "file edit view insert format tools table help",
    "plugins": "advlist lists link image charmap emoticons anchor searchreplace visualblocks code "
    "media table code help",
    "toolbar": "undo redo | bold italic underline strikethrough | fontselect fontsizeselect formatselect | "
    "numlist bullist | forecolor "
    "backcolor casechange | charmap emoticons | "
    "insertfile image medialink anchor codesample | ",
    "promotion": False,
    "object_resizing": "img",
    "file_picker_types": "image",
    "file_picker_callback": """function (cb, value, meta) {
        var input = document.createElement("input");
        input.setAttribute("type", "file");
        if (meta.filetype == "image") {
            input.setAttribute("accept", "image/*");
        }

        input.onchange = function () {
            var file = this.files[0];
            var reader = new FileReader();
            reader.onload = function () {
                var id = "blobid" + (new Date()).getTime();
                var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                var base64 = reader.result.split(",")[1];
                var blobInfo = blobCache.create(id, file, base64);
                blobCache.add(blobInfo);
                cb(blobInfo.blobUri(), { title: file.name });
            };
            reader.readAsDataURL(file);
        };
        input.click();
    }""",
    "content_style": "body { font-family:Roboto,Helvetica,Arial,sans-serif; font-size:14px }",
}
