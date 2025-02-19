from enum import Enum

from django.utils.translation import gettext_lazy as _


class UserRole(Enum):
    ADMIN = _("Admin")
    OFFICE_HKI = _("Office Hki")
    OFFICE = _("Office")
    PUBLIC = _("Public")
