#!/bin/bash

# Listar todos os tipos de Flagging e contagem de registros
echo "Listando todos os tipos de Flagging:"
lando drush eval "
\$flagging_types = \Drupal::entityTypeManager()->getStorage('flag')->loadMultiple();
foreach (\$flagging_types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('flagging')->condition('flag_id', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' registros' . PHP_EOL;
}
"
