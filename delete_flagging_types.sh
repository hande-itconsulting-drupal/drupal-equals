#!/bin/bash

# Array de tipos de "Flagging" a serem deletados (use os nomes de máquina corretos listados anteriormente)
flagging_types_to_delete=(
  "bookmark"
  "like"
)

# Função para verificar se uma tabela existe
table_exists() {
  lando drush sql-query "SHOW TABLES LIKE '$1';" | grep -q "$1"
}

# Deletar registros de "Flagging"
echo "Deletando registros de Flagging"
for flagging_type in "${flagging_types_to_delete[@]}"; do
  echo "Deletando registros do tipo $flagging_type"
  
  if table_exists "flagging"; then
    lando drush sql-query "DELETE FROM flagging WHERE flag_id = '$flagging_type';"
    echo "SUCCESS: Deleted flagging of type: $flagging_type from flagging table"
  else
    echo "Table 'flagging' does not exist"
  fi
  
  if table_exists "flagging_field_data"; then
    lando drush sql-query "DELETE FROM flagging_field_data WHERE flag_id = '$flagging_type';"
    echo "SUCCESS: Deleted flagging of type: $flagging_type from flagging_field_data table"
  else
    echo "Table 'flagging_field_data' does not exist"
  fi

done

echo "Todos os tipos especificados de flagging foram deletados."
echo "Processo concluído."
