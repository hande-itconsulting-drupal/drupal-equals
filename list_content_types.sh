#!/bin/bash

# Listar todos os tipos de conteúdo e contagem de nodes
echo "Listing all content types and node counts:"
lando drush eval "
\$types = \Drupal::entityTypeManager()->getStorage('node_type')->loadMultiple();
foreach (\$types as \$type) {
  \$type_id = \$type->id();
  \$type_label = \$type->label();
  \$count = \Drupal::entityQuery('node')->condition('type', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' nodes' . PHP_EOL;
}"
