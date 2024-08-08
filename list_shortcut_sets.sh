#!/bin/bash

# Listar todos os tipos de "Shortcut set" e contagem de registros
echo "Listing all shortcut sets:"
lando drush eval "
\$sets = \Drupal::entityTypeManager()->getStorage('shortcut_set')->loadMultiple();
foreach (\$sets as \$set) {
  \$set_id = \$set->id();
  \$set_label = \$set->label();
  \$count = \Drupal::entityQuery('shortcut')->condition('set', \$set_id)->count()->execute();
  echo \$set_label . ' (' . \$set_id . ') | ' . \$count . ' registros' . PHP_EOL;
}
"
