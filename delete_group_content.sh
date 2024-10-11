#!/bin/bash

# Array de tipos de "Group content" a serem deletados
group_content_types_to_delete=(
 ""
 ""
)

# Loop através de cada tipo de "Group content" e deletar os registros associados
for group_content_type in "${group_content_types_to_delete[@]}"; do
  if [ "$group_content_type" == "company-group_node-news" ]; then
    # Deletar registros do tipo 'company-group_node-news' diretamente no banco de dados
    echo "Deletando registros do tipo company-group_node-news"
    lando drush sql-query "DELETE FROM group_content WHERE type = 'company-group_node-news';"
    lando drush sql-query "DELETE FROM group_content_field_data WHERE type = 'company-group_node-news';"
    if [ $? -eq 0 ]; then
      echo "SUCCESS: Deleted group content of type: $group_content_type"
    else
      echo "ERROR: Failed to delete group content of type: $group_content_type"
    fi
  else
    # Deletar os demais tipos de "Group content" usando o comando padrão
    echo "Deleting group content of type: $group_content_type"
    lando drush entity:delete group_content --bundle="$group_content_type"
    if [ $? -eq 0 ]; then
      echo "SUCCESS: Deleted group content of type: $group_content_type"
    else
      echo "ERROR: Failed to delete group content of type: $group_content_type"
    fi
  fi
done

echo "All specified group content entities have been deleted."
echo "Processo concluído."
