FROM neibrs/drupal
ENV DEBIAN_FRONTEND noninteractive

RUN apt install -y curl

# Install stable version of eabax modules
COPY files/.ssh_config /root/.ssh/config
RUN apt-get install -y sshpass
#RUN sshpass -p 39cb3ae0 git clone -b 19.11 ssh://git@114.215.42.138/opt/git/eabax.git /var/www/html/modules/eabax

# Setup eabax_seven theme

#RUN apt-get install -y gnupg apt-transport-https && \
#  curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#  apt-get update && apt-get install -y yarn
RUN apt-get install -y gnupg apt-transport-https && \
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install -y nodejs
RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
#&& \
#  cd modules/eabax/core/eabax_core && \
#  yarn install

RUN PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
#&& \
#  cd modules/eabax/themes/eabax_seven && \
#  yarn install

# Finish
EXPOSE 80 3306 22 443
CMD exec supervisord -n

