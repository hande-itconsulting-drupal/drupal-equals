#!/bin/bash

# Listar todos os vocabulários de taxonomia e a quantidade de termos em cada vocabulário
echo "Listing all taxonomy vocabularies and the count of terms in each:"
lando drush eval "
  \$vocabularies = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->loadMultiple();
  foreach (\$vocabularies as \$vocabulary) {
    \$vocabulary_id = \$vocabulary->id();
    \$vocabulary_label = \$vocabulary->label();
    \$count = \Drupal::entityQuery('taxonomy_term')->condition('vid', \$vocabulary_id)->count()->execute();
    echo \$vocabulary_label . ' (' . \$vocabulary_id . ') | ' . \$count . ' terms' . PHP_EOL;
  }
"