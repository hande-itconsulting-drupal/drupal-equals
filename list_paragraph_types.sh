#!/bin/bash

# Listar todos os tipos de parágrafos e contagem de registros
echo "Listando todos os tipos de Parágrafos:"
lando drush eval "
\$paragraph_types = \Drupal::entityTypeManager()->getStorage('paragraphs_type')->loadMultiple();
foreach (\$paragraph_types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('paragraph')->condition('type', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' registros' . PHP_EOL;
}
"