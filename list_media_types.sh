#!/bin/bash

# Listar todos os tipos de media e contagem de registros
echo "Listando todos os tipos de Media:"
lando drush eval "
\$media_types = \Drupal::entityTypeManager()->getStorage('media_type')->loadMultiple();
foreach (\$media_types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('media')->condition('bundle', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' files' . PHP_EOL;
}"
