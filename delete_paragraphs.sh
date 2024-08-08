#!/bin/bash

# Lista de tipos de parágrafos a serem deletados
paragraph_types=(
  "text_widget_custom"
  "webform"
  "video"
  "action_or_tool_teaser"
  "timeline_theme"
  "timeline_mark"
  "timeline_initiative"
  "timeline"
  "text_button"
  "table"
  "multiple_image"
  "single_facts_and_figures"
  "rich_text_with_single_image"
  "rich_text"
  "rich_text_agencia"
  "remote_video"
  "remote_image"
  "remote_document"
  "related_content"
  "profile_information"
  "primary_button"
  "person_teaser"
  "person_quote"
  "parallax_image"
  "painel"
  "page_teaser"
  "notification_translation"
  "news_teaser"
  "megateaser_pagina_externa"
  "megateaser"
  "managers"
  "magazine_archive"
  "single_image"
  "building_collaborators"
  "infospot_teaser"
  "image_with_text"
  "image_with_link_hover_text"
  "image_with_link"
  "image_gallery"
  "illustrated_list_section"
  "illustrated_list"
  "iframe"
  "graph"
  "facts_and_figures"
  "events_teaser"
  "event_detail"
  "event_date"
  "custom_managers"
  "item_with_image_or_icon"
  "icon"
  "documents_list"
  "document_teaser"
  "countdown"
  "cookies_management"
  "content_exit"
  "contact"
  "complex_rich_text"
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
  "buttons"
  "tabs"
  "tab_section"
  "section"
  "faq"
  "body"
  "big_banner"
  "apontador"
  "accordion"
  "audiencias"
)

# Funções para colorir mensagens
info() {
  echo -e "$(tput setaf 2)INFO: $1$(tput sgr0)"
}

warning() {
  echo -e "$(tput setaf 3)WARNING: $1$(tput sgr0)"
}

error() {
  echo -e "$(tput setaf 1)ERROR: $1$(tput sgr0)"
}

success() {
  echo -e "$(tput setaf 2)SUCCESS: $1$(tput sgr0)"
}

# Função para deletar parágrafos
delete_paragraph() {
  local paragraph_type=$1
  info "Deleting paragraph of type: $paragraph_type"
  lando drush entity:delete paragraph --bundle=$paragraph_type
  if [ $? -eq 0 ]; then
    success "Deleted paragraph of type: $paragraph_type"
  else
    error "Failed to delete paragraph of type: $paragraph_type"
  fi
}

# Loop através dos tipos de parágrafos e deletar os parágrafos
for paragraph_type in "${paragraph_types[@]}"; do
  delete_paragraph $paragraph_type
done

success "All specified paragraph types have been deleted."
