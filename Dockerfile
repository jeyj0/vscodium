FROM ubuntu

RUN apt-get update && apt-get install -yq sudo

WORKDIR /vscodium

RUN apt-get install -yq curl
RUN apt-get install -yq wget

ENV SHOULD_BUILD="yes"
ENV BUILDARCH="x64"

COPY install_deps.sh .
RUN ./install_deps.sh

# installing node
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -yq nodejs

# installing yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -yq yarn

COPY check_tags.sh .
RUN ./check_tags.sh

COPY . .

RUN ./build.sh

# RUN ./sign_mac_app.sh
RUN ./create_zip.sh
RUN ./create_dmg.sh
RUN ./sum.sh

CMD [ "ls" ]
# CMD [ "./sum.sh && ls" ]
