from .base import *

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'cx8&=ho5h7_(0i_g&(j%@^0)3)(*lw7xq^2a2&v=4sder2gwaj'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ["django", '0.0.0.0', 'localhost', '127.0.0.1']

INSTALLED_APPS += [
    'django_extensions',
]
