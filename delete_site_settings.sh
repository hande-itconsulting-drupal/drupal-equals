#!/bin/bash

# Nome correto da entidade "Site Setting"
entity_type="site_setting_entity"

# Array de tipos de "Site Setting" a ser deletado
site_setting_types=(
   
)

# Loop através de cada tipo de "Site Setting", deletar as entidades associadas
for type in "${site_setting_types[@]}"; do
  echo "Deleting site setting entities of type: $type"
  lando drush entity:delete $entity_type --bundle="$type"
done

echo "All specified site setting entities have been deleted."
