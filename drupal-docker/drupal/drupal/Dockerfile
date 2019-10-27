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

# Install Drupal modules
RUN composer require \
  drupal/r4032login \
  drupal/address \
  drupal/ajax_links_api \
  drupal/block_style_plugins:dev-2.x \
  drupal/conditional_fields \
  drupal/custom_formatters \
  drupal/entity_browser \
  drupal/facets \
  drupal/features \
  drupal/field_formatter_class \
  drupal/field_group \
  drupal/inline_entity_form \
  drupal/pinyin \
  drupal/quicktabs \
  drupal/reference_table_formatter \
  drupal/rules \
  drupal/search_api_solr \
  drupal/token \
  drupal/token_filter \
  drush/drush \
  drupal/console \
  drupal/views_field_formatter

# If PHP filter is empty, module should return TRUE and not execute code
# https://www.drupal.org/project/php/issues/2678430
#RUN cd modules/contrib/php && \
#  wget https://www.drupal.org/files/issues/php_condition_check_empty-2678430-13.patch && \
#  patch -p1 < php_condition_check_empty-2678430-13.patch && \
#  rm php_condition_check_empty-2678430-13.patch

# Install charts
RUN composer require drupal/charts

# Install entity_print
RUN composer require drupal/entity_print \
  mikehaertl/phpwkhtmltopdf \
  drupal/eva \
  drupal/field_widget_class

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

# Install migrate modules

RUN composer require \
  drupal/csv_serialization \
  drupal/default_content \
  drupal/migrate_plus \
  drupal/migrate_source_csv \
  drupal/migrate_source_xls \
  drupal/migrate_tools \
  drupal/xls_serialization

# Install api-first modules
RUN composer require \
  #drupal/graphql \
  drupal/restui
  # [ERROR] Incomplete or missing schema for simple_oauth.oauth2_token.bundle.
  #drupal/simple_oauth

# Configuration management
RUN composer require drupal/config_rewrite

# Install memcache modules
RUN composer require \
  drupal/memcache
#COPY files/settings.memcache.php sites/default/settings.memcache.php

# Install varnish_purge
RUN composer require \
  drupal/purge \
  drupal/varnish_purge

# Mysql server config
COPY files/60-drupal.cnf /etc/mysql/conf.d/60-drupal.cnf

COPY files/install-drupal.sh install-drupal.sh
RUN chmod +x install-drupal.sh

# Finish
EXPOSE 80 3306 22 443
CMD exec supervisord -n

