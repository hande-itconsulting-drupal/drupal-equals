#!/bin/bash

# Array de tipos de "Media" a serem deletados
media_types_to_delete=(
    "video"               
    "remote_video"        
    "remote_image"        
    "remote_document"     
    "remote"              
    "multiple_documents"  
    "image"               
    "dw_document"         
    "code_of_ethics_pdf"  
    "code_of_ethics_image"
    "svg_media_teste"
)

# Deletar registros de "Media"
echo "Deletando registros de Media"
for media_type in "${media_types_to_delete[@]}"; do
  echo "Deletando registros do tipo $media_type"
  lando drush sql-query "DELETE FROM media WHERE bundle = '$media_type';"
  lando drush sql-query "DELETE FROM media_field_data WHERE bundle = '$media_type';"
  if [ $? -eq 0 ]; then
    echo "SUCCESS: Deleted media of type: $media_type"
  else
    echo "ERROR: Failed to delete media of type: $media_type"
  fi
done

echo "Todos os tipos especificados de media foram deletados."
echo "Processo concluído."
