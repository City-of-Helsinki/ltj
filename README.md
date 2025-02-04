[![Build status](https://travis-ci.org/City-of-Helsinki/ltj.svg?branch=master)](https://travis-ci.org/City-of-Helsinki/ltj)
[![codecov](https://codecov.io/gh/City-of-Helsinki/ltj/branch/master/graph/badge.svg)](https://codecov.io/gh/City-of-Helsinki/ltj)
[![Requirements](https://requires.io/github/City-of-Helsinki/ltj/requirements.svg?branch=master)](https://requires.io/github/City-of-Helsinki/ltj/requirements/?branch=master)

# City of Helsinki nature database and API (LTJ)

LTJ is a backend service for storing and retrieving data about important
natural sites and observations thereof. This information is structured
along the form of a database developed in the City of Helsinki during several
years. It is not particularly specific to Helsinki and should be usable
elsewhere as well.

Data in LTJ is accessed throught its REST-like API. In addition there is a
reasonably functional admnistration site implemented using Django admin.
In case you are not familiar with Django admin, it is a simple forms based
editor of Web 1.0 style.

LTJ also has support for displaying HTML-formatted reports for natural
sites. These are designed for linking from the Helsinki map service
(kartta.hel.fi).
 

### Prerequisites

* Python 3.10
* Django 4.2 LTS
* PostgreSQL with PostGIS
* gunicorn 21.2


## Preferred usage with Visual Studio Code

Install Remote Containers support in Visual Studio Code with these instructions:

* https://code.visualstudio.com/docs/remote/remote-overview
* https://code.visualstudio.com/docs/remote/containers

After that this should be easy, if all that magic works:

* Open the project folder in Visual Studio Code
* It asks to reopen the folder in remote container
* Accept
* Wait a while for it to automatically build the environment for you 

You are free to change the included VSCode settings locally for yourself but it is
expected that you produce code which pass linters defined in the preferred settings.

In the debug panel you can run following with debugger enabled:

* Django runserver in hot reload mode
* Django shell
* Django migrations
* Generate new Django migrations for all Django apps

Happy hacking :)


### Configuration

LTJ uses `local_settings` settings module and environment variables for
its configuration. Environmental variables are handled using
`django-environ` -module.

Configuration base for for `local_settings` can be found from file
`local_settings.py.tpl_dev` file. VSCode remote container setup should copy
this automatically as devault configuration file.

For `django-environ` also `config.env` can be created in the root of the source
(ie. same place as this README). Start by renaming `config.env.example` to
`config.env`. The example file should contain every setting currently available
and commonly used values thereof.


### Tests

Run tests

    py.test

Run tests with coverage report

    py.test --cov-report html --cov .
    
Open htmlcov/index.html for the coverage report.


### Translations

To compile the Finnish translations run

    python manage.py compilemessages
