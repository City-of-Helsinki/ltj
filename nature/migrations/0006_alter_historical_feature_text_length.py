# -*- coding: utf-8 -*-
# Generated by Django 1.11.13 on 2018-06-13 10:41
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("nature", "0005_link_text_length_100"),
    ]

    operations = [
        migrations.AlterField(
            model_name="historicalfeature",
            name="text",
            field=models.CharField(
                blank=True, db_column="teksti", max_length=40000, null=True
            ),
        ),
        migrations.AlterField(
            model_name="historicalfeature",
            name="text_www",
            field=models.CharField(
                blank=True, db_column="teksti_www", max_length=40000, null=True
            ),
        ),
    ]
