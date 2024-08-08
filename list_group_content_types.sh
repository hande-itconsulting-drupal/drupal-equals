#!/bin/bash

# Listar todos os tipos de conteúdo do grupo e contagem de nodes
echo "Listing all group content types and node counts:"
lando drush eval "
\$group_types = \Drupal::service('entity_type.manager')->getStorage('group_content_type')->loadMultiple();
foreach (\$group_types as \$group_type) {
  \$type_id = \$group_type->id();
  \$type_label = \$group_type->label();
  \$count = \Drupal::entityQuery('group_content')->condition('type', \$type_id)->count()->execute();
  echo \$type_label . ' (' . \$type_id . ') | ' . \$count . ' nodes' . PHP_EOL;
}"
