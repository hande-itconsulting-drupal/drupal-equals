#!/bin/bash

# Listar todos os tipos de Crop e contagem de registros
echo "Listando todos os tipos de Crop:"
lando drush eval "
\$crop_types = \Drupal::entityTypeManager()->getStorage('crop_type')->loadMultiple();
foreach (\$crop_types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('crop')->condition('type', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' registros' . PHP_EOL;
}
"
