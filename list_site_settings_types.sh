#!/bin/bash

# Listar todos os tipos de "Site Setting" existentes e a quantidade de entidades para cada tipo
echo "Listing all site setting types and the count of entities for each type:"
lando drush eval "
\$types = \Drupal::entityTypeManager()->getStorage('site_setting_entity_type')->loadMultiple();
foreach (\$types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('site_setting_entity')->condition('type', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' registros' . PHP_EOL;
}
"
