#!/bin/bash

# Tipos de "Group content" com rótulos incompletos a serem corrigidos
declare -A group_content_types_to_fix=(
  ["company-group_media-dw_document"]="Company: Group media (Document)"
  ["company-group_membership"]="Company: Group membership"
  ["company-group_node-events"]="Company: Group node (Eventos)"
  ["company-group_node-hint"]="Company: Group node (Dicas)"
  ["company-group_node-installation"]="Company: Group node (Building)"
  ["company-group_node-landing_page"]="Company: Group node (Landing Page)"
  ["company-group_node-news"]="Company: Group node (News)"
  ["company-group_node-notifications"]="Company: Group node (Notifications)"
  ["company-group_node-page"]="Company: Group node (Página)"
  ["company-group_node-person"]="Company: Group node (Pessoa)"
  ["company-group_node-tool"]="Company: Group node (Ferramentas)"
  ["company-group_node-webform"]="Company: Group node (Webform)"
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
