# Generated by Django 2.1.7 on 2019-03-25 10:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("nature", "0013_update_series_verbose_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="featurelink",
            name="ordering",
            field=models.IntegerField(
                db_column="jarjestys", default=0, verbose_name="ordering"
            ),
        ),
    ]
