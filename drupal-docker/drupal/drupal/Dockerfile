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
  drupal/purge \
  drupal/config_rewrite \
  drupal/config_update \
  drupal/memcache \
  drupal/restui \
  drupal/page_manager \
  drupal/panels \
  drupal/panelizer \
#  drupal/csv_serialization \
  drupal/default_content \
  drupal/migrate_plus \
  drupal/migrate_source_csv \
  drupal/migrate_source_xls \
  drupal/migrate_tools \
  drupal/xls_serialization \
  drupal/entity_print \
  mikehaertl/phpwkhtmltopdf \
  drupal/charts \
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
#  drupal/search_api_solr \
  drupal/token \
  drupal/token_filter \
  drupal/views_field_formatter \
  drupal/ajax_links_api \
  drupal/varnish_purge \
  drupal/adminimal_admin_toolbar \
  drupal/coffee \
  drupal/color_field \
  drupal/commerce \
  drupal/commerce_recurring \
  drupal/cog \
  drupal/console \
  drush/drush \
  drupal/drush_language \
  kgaut/potx \
  drupal/block_style_plugins \
  drupal/typed_data \
  drupal/geofield \
  drupal/baidu_map \
  drupal/geocoder \
  drupal/computed_field \
  drupal/geolocation \
  drupal/geocoder_autocomplete \
  drupal/block_class \
  drupal/ds \
  drupal/superfish \
  drupal/libraries \
  drupal/commerce_autosku \
  drupal/views_slideshow \
  drupal/views_slideshow_cycle \
  drupal/login_security \
  drupal/smart_ip \
  drupal/if_then_else \
  drupal/purge_purger_http \
  drupal/xhprof \
  drupal/components \
  drupal/cog \
  drupal/devel

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

# Install varnish_purge
RUN composer require \
  drupal/purge \
  drupal/varnish_purge

# Mysql server config
#COPY files/60-drupal.cnf /etc/mysql/conf.d/60-drupal.cnf

#COPY files/install-drupal.sh install-drupal.sh
#RUN chmod +x install-drupal.sh

# Finish
EXPOSE 80 3306 22 443
CMD exec supervisord -n

