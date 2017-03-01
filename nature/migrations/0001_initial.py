# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-27 12:47
from __future__ import unicode_literals

import django.contrib.gis.db.models.fields
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Abundance',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('source', models.CharField(blank=True, db_column='lahde', max_length=50, null=True)),
                ('value', models.CharField(blank=True, db_column='arvo', max_length=5, null=True)),
            ],
            options={
                'db_table': 'runsaus',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='BreedingCategory',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('source', models.CharField(blank=True, db_column='lahde', max_length=50, null=True)),
                ('value', models.CharField(blank=True, db_column='arvo', max_length=50, null=True)),
            ],
            options={
                'db_table': 'pesimisvarmuus',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ConservationProgramme',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=20, null=True)),
            ],
            options={
                'db_table': 'sohjelma',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Criterion',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('criterion', models.CharField(blank=True, db_column='peruste', max_length=50, null=True)),
                ('specific_criterion', models.CharField(blank=True, db_column='tarkperuste', max_length=50, null=True)),
                ('subcriterion', models.CharField(blank=True, db_column='alaperuste', max_length=50, null=True)),
            ],
            options={
                'db_table': 'suoperuste',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Event',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('register_id', models.CharField(blank=True, db_column='diaarinro', max_length=20, null=True)),
                ('description', models.CharField(blank=True, db_column='kuvaus', max_length=255, null=True)),
                ('last_modified_by', models.CharField(blank=True, db_column='paivittaja', max_length=20, null=True)),
                ('date', models.DateField(blank=True, db_column='pvm', null=True)),
                ('link', models.CharField(blank=True, db_column='linkki', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'tapahtuma',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='EventFeature',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'tapahtuma_kohde',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='EventRegulation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'tap_saados',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='EventType',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=20, null=True)),
            ],
            options={
                'db_table': 'tapahtumatyyppi',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Feature',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('type', models.CharField(blank=True, db_column='tunnus', max_length=10, null=True)),
                ('geometry1', django.contrib.gis.db.models.fields.GeometryField(srid=4326)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=80, null=True)),
                ('description', models.CharField(blank=True, db_column='kuvaus', max_length=255, null=True)),
                ('notes', models.CharField(blank=True, db_column='huom', max_length=255, null=True)),
                ('active', models.BooleanField(db_column='voimassa')),
                ('created_time', models.DateField(blank=True, db_column='digipvm', null=True)),
                ('number', models.IntegerField(blank=True, db_column='numero', null=True)),
                ('created_by', models.CharField(blank=True, db_column='digitoija', max_length=50, null=True)),
                ('last_modified_time', models.DateTimeField(blank=True, db_column='pvm_editoitu', null=True)),
                ('last_modified_by', models.CharField(blank=True, db_column='muokkaaja', max_length=10, null=True)),
                ('area', models.FloatField(blank=True, db_column='pinta_ala', null=True)),
                ('text', models.CharField(blank=True, db_column='teksti', max_length=4000, null=True)),
                ('text_www', models.CharField(blank=True, db_column='teksti_www', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'kohde',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='FeatureClass',
            fields=[
                ('id', models.CharField(db_column='tunnus', max_length=10, primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=50, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('reporting', models.BooleanField(db_column='raportointi')),
                ('www', models.BooleanField()),
                ('metadata', models.CharField(blank=True, max_length=4000, null=True)),
            ],
            options={
                'db_table': 'luokka',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='FeatureLink',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('link', models.CharField(blank=True, db_column='link', max_length=4000, null=True)),
                ('text', models.CharField(blank=True, db_column='linkkiteksti', max_length=4000, null=True)),
                ('ordering', models.IntegerField(blank=True, db_column='jarjestys', null=True)),
                ('link_text', models.CharField(blank=True, db_column='linkin_teksti ', max_length=1000, null=True)),
            ],
            options={
                'db_table': 'kohdelinkki',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='FeaturePublication',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'kohde_julk',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='HabitatType',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=50, null=True)),
                ('code', models.CharField(blank=True, db_column='koodi', max_length=10, null=True)),
                ('description', models.CharField(blank=True, db_column='kuvaus', max_length=255, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('group', models.CharField(blank=True, db_column='ltyyppiryhma', max_length=50, null=True)),
            ],
            options={
                'db_table': 'ltyyppirekisteri',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='HabitatTypeObservation',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('group_fraction', models.IntegerField(blank=True, db_column='osuus_kuviosta', null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('created_time', models.DateTimeField(db_column='pvm_luotu')),
                ('last_modified_time', models.DateTimeField(blank=True, db_column='pvm_editoitu', null=True)),
            ],
            options={
                'db_table': 'ltyyppihavainto',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='HabitatTypeRegulation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'ltyyppi_saados',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Incidence',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('source', models.CharField(blank=True, db_column='lahde', max_length=50, null=True)),
                ('value', models.CharField(blank=True, db_column='arvo', max_length=5, null=True)),
            ],
            options={
                'db_table': 'yleisyys',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='LinkType',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=20, null=True)),
            ],
            options={
                'db_table': 'linkkityyppi',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Mobility',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('source', models.CharField(blank=True, db_column='lahde', max_length=50, null=True)),
                ('value', models.IntegerField(blank=True, db_column='arvo', null=True)),
            ],
            options={
                'db_table': 'liikkumislk',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Observation',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('number', models.CharField(blank=True, db_column='lkm', max_length=30, null=True)),
                ('description', models.CharField(blank=True, db_column='kuvaus', max_length=255, null=True)),
                ('notes', models.CharField(blank=True, db_column='huom', max_length=100, null=True)),
                ('date', models.DateField(blank=True, db_column='pvm', null=True)),
                ('created_time', models.DateTimeField(db_column='pvm_luotu')),
                ('last_modified_time', models.DateTimeField(blank=True, db_column='pvm_editoitu', null=True)),
            ],
            options={
                'db_table': 'lajihavainto',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ObservationSeries',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=50, null=True)),
                ('description', models.CharField(blank=True, db_column='kuvaus', max_length=255, null=True)),
                ('start_date', models.DateField(blank=True, db_column='alkupvm', null=True)),
                ('end_date', models.DateField(blank=True, db_column='loppupvm', null=True)),
                ('method', models.CharField(blank=True, db_column='menetelma', max_length=255, null=True)),
                ('notes', models.CharField(blank=True, db_column='huomioitavaa', max_length=255, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('valid', models.BooleanField(db_column='voimassa')),
            ],
            options={
                'db_table': 'havaintosarja',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Occurrence',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
            ],
            options={
                'db_table': 'esiintyma',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Origin',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('source', models.CharField(blank=True, db_column='lahde', max_length=50, null=True)),
            ],
            options={
                'db_table': 'alkupera',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Person',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('surname', models.CharField(blank=True, db_column='sukunimi', max_length=25, null=True)),
                ('first_name', models.CharField(blank=True, db_column='etunimi', max_length=25, null=True)),
                ('expertise', models.CharField(blank=True, db_column='asiantuntemus', max_length=150, null=True)),
                ('notes', models.CharField(blank=True, db_column='huomioitavaa', max_length=255, null=True)),
                ('company', models.CharField(blank=True, db_column='yritys', max_length=100, null=True)),
                ('public_servant', models.BooleanField(db_column='viranomainen')),
                ('telephone', models.CharField(blank=True, db_column='puhnro', max_length=50, null=True)),
                ('email', models.CharField(blank=True, db_column='email', max_length=100, null=True)),
                ('created_time', models.DateTimeField(blank=True, db_column='lisaysaika', null=True)),
            ],
            options={
                'db_table': 'henkilo',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ProtectionConservationProgramme',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'suojelu_sohjelma',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ProtectionCriterion',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'suo_peruste',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ProtectionLevel',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
            ],
            options={
                'db_table': 'suojaustaso',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Publication',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=150, null=True)),
                ('author', models.CharField(blank=True, db_column='tekija', max_length=100, null=True)),
                ('series', models.CharField(blank=True, db_column='sarja', max_length=100, null=True)),
                ('place_of_printing', models.CharField(blank=True, db_column='painopaikka', max_length=50, null=True)),
                ('year', models.CharField(blank=True, db_column='vuosi', max_length=50, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('link', models.CharField(blank=True, db_column='linkki', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'julkaisu',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='PublicationType',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=20, null=True)),
            ],
            options={
                'db_table': 'julktyyppi',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Regulation',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, db_column='nimi', max_length=255, null=True)),
                ('paragraph', models.CharField(blank=True, db_column='pykala', max_length=100, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('value', models.CharField(blank=True, db_column='arvo', max_length=10, null=True)),
                ('value_explanation', models.CharField(blank=True, db_column='arvon_selitys', max_length=255, null=True)),
                ('valid', models.BooleanField(db_column='voimassa')),
                ('date_of_entry', models.DateTimeField(blank=True, db_column='voimaantulo', null=True)),
                ('link', models.CharField(blank=True, db_column='linkki', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'saados',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Species',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('taxon', models.CharField(blank=True, db_column='ryhma', max_length=5, null=True)),
                ('taxon_1', models.CharField(blank=True, db_column='elioryhma1', max_length=50, null=True)),
                ('taxon_2', models.CharField(blank=True, db_column='elioryhma2', max_length=50, null=True)),
                ('order_fi', models.CharField(blank=True, db_column='lahko_suomi', max_length=150, null=True)),
                ('order_la', models.CharField(blank=True, db_column='lahko_tiet', max_length=150, null=True)),
                ('family_fi', models.CharField(blank=True, db_column='heimo_suomi', max_length=150, null=True)),
                ('family_la', models.CharField(blank=True, db_column='heimo_tiet', max_length=150, null=True)),
                ('name_fi_1', models.CharField(blank=True, db_column='nimi_suomi1', max_length=150, null=True)),
                ('name_fi_2', models.CharField(blank=True, db_column='nimi_suomi2', max_length=150, null=True)),
                ('name_la_1', models.CharField(blank=True, db_column='nimi_tiet1', max_length=150, null=True)),
                ('name_la_2', models.CharField(blank=True, db_column='nimi_tiet2', max_length=150, null=True)),
                ('subspecies_1', models.CharField(blank=True, db_column='alalaji1', max_length=150, null=True)),
                ('subspecies_2', models.CharField(blank=True, db_column='alalaji2', max_length=150, null=True)),
                ('author_1', models.CharField(blank=True, db_column='auktori1', max_length=150, null=True)),
                ('author_2', models.CharField(blank=True, db_column='auktori2', max_length=150, null=True)),
                ('name_abbreviated_1', models.CharField(blank=True, db_column='nimilyhenne1', max_length=10, null=True)),
                ('name_abbreviated_2', models.CharField(blank=True, db_column='nimilyhenne2', max_length=10, null=True)),
                ('name_sv', models.CharField(blank=True, db_column='nimi_ruotsi', max_length=150, null=True)),
                ('name_en', models.CharField(blank=True, db_column='nimi_englanti', max_length=150, null=True)),
                ('registry_date', models.DateTimeField(blank=True, db_column='rekisteripvm', null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
                ('code', models.CharField(blank=True, db_column='koodi', max_length=20, null=True)),
                ('link', models.CharField(blank=True, db_column='linkki', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'lajirekisteri',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='SpeciesRegulation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'laj_saa',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Value',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('explanation', models.CharField(blank=True, db_column='selitys', max_length=50, null=True)),
                ('type', models.CharField(blank=True, db_column='luokka', max_length=10, null=True)),
                ('valuator', models.CharField(blank=True, db_column='arvottaja', max_length=50, null=True)),
                ('date', models.DateField(blank=True, db_column='pvm', null=True)),
                ('link', models.CharField(blank=True, db_column='linkki', max_length=4000, null=True)),
            ],
            options={
                'db_table': 'arvo',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ValueFeature',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
            options={
                'db_table': 'arvo_kohde',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='HistoricalFeature',
            fields=[
                ('feature_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='nature.Feature')),
                ('archived_time', models.DateTimeField(db_column='historia_pvm')),
            ],
            options={
                'db_table': 'kohde_historia',
                'managed': False,
            },
            bases=('nature.feature',),
        ),
        migrations.CreateModel(
            name='Protection',
            fields=[
                ('id', models.OneToOneField(db_column='id', on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='protection', serialize=False, to='nature.Feature')),
                ('reported_area', models.CharField(blank=True, db_column='ilmoitettu_pinta_ala', max_length=50, null=True)),
                ('land_area', models.CharField(blank=True, db_column='maapinta_ala', max_length=50, null=True)),
                ('water_area', models.CharField(blank=True, db_column='vesipinta_ala', max_length=50, null=True)),
                ('hiking', models.CharField(blank=True, db_column='liikkuminen', max_length=255, null=True)),
                ('regulations', models.CharField(blank=True, db_column='maaraykset', max_length=255, null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
            ],
            options={
                'db_table': 'suojelu',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Tile',
            fields=[
                ('id', models.OneToOneField(db_column='id', on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='tile', serialize=False, to='nature.Feature')),
                ('number', models.CharField(blank=True, db_column='nro', max_length=10, null=True)),
                ('degree_of_determination', models.IntegerField(blank=True, db_column='selvitysaste', null=True)),
                ('additional_info', models.CharField(blank=True, db_column='lisatieto', max_length=255, null=True)),
            ],
            options={
                'db_table': 'ruutu',
                'managed': False,
            },
        ),
    ]