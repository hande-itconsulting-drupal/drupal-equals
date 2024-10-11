#!/bin/bash

# Array de vocabulários para deletar
vocabularies=(

)

# Loop através de cada vocabulário, deletar os termos de taxonomia associados e depois deletar o vocabulário
for vocabulary in "${vocabularies[@]}"; do
  echo "Deleting taxonomy terms in vocabulary: $vocabulary"
  lando drush entity:delete taxonomy_term --bundle="$vocabulary"
  echo "Deleting taxonomy vocabulary: $vocabulary"
  lando drush entity:delete taxonomy_vocabulary "$vocabulary"
done

echo "All specified taxonomy terms and vocabularies have been deleted."
