#!/bin/bash

# Tipos de "Group content" com rótulos incompletos a serem corrigidos
declare -A group_content_types_to_fix=(
  ["machine-name-group-content-a"]="New rotule"
  ["machine-name-group-content-b"]="New rotule"  
)

# Loop através de cada tipo de "Group content" e corrigir os rótulos
for type in "${!group_content_types_to_fix[@]}"; do
  label=${group_content_types_to_fix[$type]}
  echo "Fixing label for group content type: $type"
  lando drush eval "
  \$type = \Drupal::entityTypeManager()->getStorage('group_content_type')->load('$type');
  if (\$type) {
    \$type->set('label', '$label');
    \$type->save();
    echo 'Fixed label for $type to $label' . PHP_EOL;
  } else {
    echo 'Group content type $type not found.' . PHP_EOL;
  }
  "
done

echo "All specified group content types have been fixed."
