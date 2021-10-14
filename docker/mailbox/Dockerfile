FROM python:3.9.1-buster

COPY Pipfile /app/Pipfile
COPY ./Pipfile.lock /app/Pipfile.lock

RUN pip install pipenv
WORKDIR /app
RUN pipenv install

CMD pipenv run twist wormhole-mailbox