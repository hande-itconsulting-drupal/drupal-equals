#!/bin/bash

# Array de vocabulários para deletar
vocabularies=(
  "widgets"
  "webform_category"
  "tools_keyword"
  "tools_category"
  "tools_actions_devices"
  "search_person_company"
  "person_company"
  "page_tags"
  "news_tags"
  "news_category"
  "magazine_year"
  "installation_category"
  "infospot_tags"
  "infospot_menu_sub_category"
  "infospot_menu"
  "infospot_language"
  "infospot_category"
  "infospot_categorias_faq"
  "image_folder"
  "dw_magazine_edition"
  "document_keywords"
  "document_category"
  "company"
  "category_widget"
  "actions_category"
  "wfuser"           
  "unidadedenegocio" 
  "sigladosorgaosedp"
  "pais"             
  "ligacoesprocessos"
  "interveniente"    
  "historicovers"    
  "grpfuncaocore"    
  "estrutura"        
  "enquadramento"    
  "eixos_e_subeixos" 
  "cidade"           
  "category"         
  "arquivofichei"
)

# Loop através de cada vocabulário, deletar os termos de taxonomia associados e depois deletar o vocabulário
for vocabulary in "${vocabularies[@]}"; do
  echo "Deleting taxonomy terms in vocabulary: $vocabulary"
  lando drush entity:delete taxonomy_term --bundle="$vocabulary"
  echo "Deleting taxonomy vocabulary: $vocabulary"
  lando drush entity:delete taxonomy_vocabulary "$vocabulary"
done

echo "All specified taxonomy terms and vocabularies have been deleted."
