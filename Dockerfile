FROM docker.haltu.net/haltu/env/bergenia:develop

# Needed step because a bug in bergenia
USER root
RUN chown -R bew:bew /home/bew
USER bew

COPY --chown=bew:bew . /home/bew/bew/

RUN python3 -m venv /home/bew/.venv
RUN /home/bew/.venv/bin/pip3 install -r /home/bew/bew/requirements.txt

RUN mkdir ~/.zsh/
RUN echo '. ~/.venv/bin/activate' >> ~/.zsh/local.zsh
RUN cp -n ~/bew/local_settings.py.tpl_dev ~/bew/local_settings.py

#RUN ln -s ../local_settings.py local_settings_bergenia.py
#RUN cp -n local_settings.py.tpl local_settings.py

#USER root
#RUN salt-call --local state.apply
#USER bew
