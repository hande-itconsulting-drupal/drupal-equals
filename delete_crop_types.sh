#!/bin/bash

# Array de tipos de "Crop" a serem deletados (use os nomes de máquina corretos listados anteriormente)
crop_types_to_delete=(
   ""
   ""
)

# Função para verificar se uma tabela existe
table_exists() {
  lando drush sql-query "SHOW TABLES LIKE '$1';" | grep -q "$1"
}

# Deletar registros de "Crop"
echo "Deletando registros de Crop"
for crop_type in "${crop_types_to_delete[@]}"; do
  echo "Deletando registros do tipo $crop_type"
  
  if table_exists "crop"; then
    lando drush sql-query "DELETE FROM crop WHERE type = '$crop_type';"
    echo "SUCCESS: Deleted crop of type: $crop_type from crop table"
  else
    echo "Table 'crop' does not exist"
  fi
  
  if table_exists "crop_field_data"; then
    lando drush sql-query "DELETE FROM crop_field_data WHERE type = '$crop_type';"
    echo "SUCCESS: Deleted crop of type: $crop_type from crop_field_data table"
  else
    echo "Table 'crop_field_data' does not exist"
  fi

done

echo "Todos os tipos especificados de crop foram deletados."
echo "Processo concluído."
