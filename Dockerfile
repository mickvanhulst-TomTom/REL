# syntax = docker/dockerfile:experimental
FROM pytorch/pytorch

# download necessary files
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    tar
RUN wget http://gem.cs.ru.nl/generic.tar.gz && tar xzf generic.tar.gz && rm generic.tar.gz
RUN wget http://gem.cs.ru.nl/wiki_2019.tar.gz && tar xzf wiki_2019.tar.gz && rm wiki_2019.tar.gz

# install REL
RUN conda install -y pip
RUN git clone https://github.com/informagi/REL && cd REL && git checkout docker && pip install -e . && cd ..

# expose the API port
EXPOSE 5555

# run REL server
ENTRYPOINT python REL/scripts/code_tutorials/run_server.py ./ wiki_2019