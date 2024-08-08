#!/bin/bash

# Lista de tipos de parágrafos a serem verificados
paragraph_types=(
  "text_widget_custom"
  "action_or_tool_teaser"
  "timeline_theme"
  "profile_information"
  "parallax_image"
  "notification_translation"
  "megateaser_pagina_externa"
  "single_image"
  "building_collaborators"
  "image_with_text"
  "facts_and_figures"
  "custom_managers"
  "item_with_image_or_icon"
  "image"
  "icon"
  "document_teaser"
  "contact"
  "code_of_ethics_video"
  "code_of_ethics_two_columns"
  "code_of_ethics_text_and_image"
  "code_of_ethics_real_situation"
  "code_of_ethics_path_item"
  "code_of_ethics_path"
  "code_of_ethics_multimedia"
  "code_of_ethics_media_gallery"
  "code_of_ethics_complaints_management"
  "code_of_ethics_image"
  "code_of_ethics_carousel"
  "tabs"
  "tab_section"
  "section"
  "faq"
  "apontador"
)

# Funções para colorir mensagens
info() {
  echo -e "$(tput setaf 2)INFO: $1$(tput sgr0)"
}

error() {
  echo -e "$(tput setaf 1)ERROR: $1$(tput sgr0)"
}

success() {
  echo -e "$(tput setaf 2)SUCCESS: $1$(tput sgr0)"
}

# Função para verificar a contagem de registros de um tipo de parágrafo
check_paragraph_type() {
  local paragraph_type=$1

  info "Checking content of paragraph type: $paragraph_type"
  count=$(lando drush eval "echo \Drupal::database()->select('paragraphs_item', 'p')->condition('type', '$paragraph_type')->countQuery()->execute()->fetchField();")
  if [ $? -ne 0 ]; then
    error "Failed to check content of paragraph type: $paragraph_type"
    return 1
  fi

  # Verificar se count é um número antes de fazer a comparação
  if [[ "$count" =~ ^[0-9]+$ ]]; then
    if [ "$count" -eq 0 ]; then
      success "No records found for paragraph type: $paragraph_type"
    else
      info "Found $count records for paragraph type: $paragraph_type"
    fi
  else
    error "Invalid count value: $count for paragraph type: $paragraph_type"
  fi
}

# Loop através dos tipos de parágrafos e verificar a contagem de registros
for paragraph_type in "${paragraph_types[@]}"; do
  check_paragraph_type $paragraph_type
done

success "All specified paragraph types have been checked."
