FROM neibrs/php


# Install system packages
RUN apt-get install -y \
  git \
  unzip \
  wget

# Install Drupal
RUN rm -rf /var/www/html
ENV DRUPAL_VERSION 20190521
RUN git clone -b 8.8.x https://git.keiu.cn/neibrs/drupal.git /var/www/html

WORKDIR /var/www/html
ENV COMPOSER_PROCESS_TIMEOUT 1200
RUN composer install



# Install Drupal site
RUN mkdir -p /var/www/html/sites/default/files && \
  chmod a+rw /var/www/html/sites/default -R && \
  cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php && \
  cp /var/www/html/sites/default/default.services.yml /var/www/html/sites/default/services.yml && \
  chmod a+rw /var/www/html/sites/default/settings.php && \
  chmod a+rw /var/www/html/sites/default/services.yml && \
  chown -R www-data:www-data /var/www/html/

# install-drupal.sh will setup /var/www/private as file_private_path, create it first
RUN mkdir -p /var/www/private && \
  chown -R www-data:www-data /var/www/private

# Mysql server config
COPY files/60-drupal.cnf /etc/mysql/conf.d/60-drupal.cnf

COPY files/install-drupal.sh install-drupal.sh
RUN chmod +x install-drupal.sh

# Finish
EXPOSE 80 3306 22 443
CMD exec supervisord -n

