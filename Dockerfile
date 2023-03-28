FROM docker.haltu.net/haltu/env/bergenia:develop

# Needed step because a bug in bergenia
USER root
RUN chown -R bew:bew /home/bew
USER bew

ENV DEBUG=True
ENV SECRET_KEY="foo"
ENV SHARED_SECRET="secret"
ENV DATABASE_URL="postgis://bergenia:bergenia@postgis:5432/bergenia"

COPY --chown=bew:bew . /home/bew/bew/

RUN python3 -m venv /home/bew/.venv
RUN /home/bew/.venv/bin/pip3 install -r /home/bew/bew/requirements.txt

#RUN ln -s ../local_settings.py local_settings_bergenia.py
#RUN cp -n local_settings.py.tpl local_settings.py

#USER root
#RUN salt-call --local state.apply
#USER bew
