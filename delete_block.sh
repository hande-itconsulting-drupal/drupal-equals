#!/bin/bash

# Array de tipos de "Content block" a serem deletados (use os nomes de máquina corretos listados anteriormente)
block_types_to_delete=(
  "basic"
)

# Loop através de cada tipo de "Content block" e deletar os registros associados
for block_type in "${block_types_to_delete[@]}"; do
  echo "Deletando content block de tipo: $block_type"
  lando drush entity:delete block_content --bundle="$block_type"
  if [ $? -eq 0 ]; then
    echo "SUCCESS: Deleted content block of type: $block_type"
  else
    echo "ERROR: Failed to delete content block of type: $block_type"
  fi
done

echo "Todos os tipos especificados de content block foram deletados."
