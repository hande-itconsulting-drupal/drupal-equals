#!/bin/bash

# Tipos de parágrafos a serem deletados conforme o log de erro
paragraph_types=(
  "widget_custom_text"
  "tools_teaser"
  "timeline_section"
  "profile_information"
  "profile_information_news"
  "parallax"
  "notifications_message"
  "content_exit_custom"
  "megateaser_page_externa"
  "limited_single_image"
  "installation_collaborators"
  "imagem_lead"
  "facts_figures"
  "edp_on_news"
  "edp_on_pages"
  "dw_item_with_image_or_icon"
  "dw_image"
  "dw_icon"
  "document"
  "contacts"
  "coe_video"
  "coe_two_columns"
  "coe_text_image"
  "coe_question_answer"
  "coe_path_item"
  "coe_path"
  "coe_multimedia"
  "coe_media_gallery"
  "coe_image_descriptions"
  "coe_image"
  "coe_carousel"
  "bp_tabs"
  "bp_tab_section"
  "bp_accordion_section"
  "bp_accordion"
  "add_apontador"
  "code_of_ethics_multimedia_home"
)

# Função para imprimir mensagens de erro
error() {
  echo -e "\033[0;31mERROR:\033[0m $1"
}

# Função para imprimir mensagens de sucesso
success() {
  echo -e "\033[0;32mSUCCESS:\033[0m $1"
}

# Função para imprimir mensagens de informação
info() {
  echo -e "\033[0;36mINFO:\033[0m $1"
}

# Função para desanexar parágrafos dos nós
detach_paragraphs() {
  local paragraph_type=$1
  lando drush eval "
    \$entity_type_manager = \Drupal::entityTypeManager();
    \$paragraph_storage = \$entity_type_manager->getStorage('paragraph');
    \$query = \$paragraph_storage->getQuery();
    \$query->condition('type', '$paragraph_type');
    \$paragraph_ids = \$query->execute();
    if (!empty(\$paragraph_ids)) {
      \$paragraphs = \$paragraph_storage->loadMultiple(\$paragraph_ids);
      foreach (\$paragraphs as \$paragraph) {
        \$paragraph->delete();
      }
    }
  "
}

# Loop através dos tipos de parágrafos e delete cada um
for paragraph_type in "${paragraph_types[@]}"; do
  info "Detaching paragraphs of type: $paragraph_type"
  detach_paragraphs "$paragraph_type"
  if [ $? -eq 0 ]; then
    success "Detached paragraphs of type: $paragraph_type"
  else
    error "Failed to detach paragraphs of type: $paragraph_type"
  fi

  info "Deleting paragraph type: $paragraph_type"
  lando drush eval "
    \$entity_type_manager = \Drupal::entityTypeManager();
    \$storage_handler = \$entity_type_manager->getStorage('paragraphs_type');
    \$paragraph_type_entity = \$storage_handler->load('$paragraph_type');
    if (\$paragraph_type_entity) {
      \$paragraph_type_entity->delete();
      echo 'Deleted paragraph type: $paragraph_type';
    } else {
      echo 'Paragraph type not found: $paragraph_type';
    }
  "
  if [ $? -eq 0 ]; then
    success "Deleted paragraph type: $paragraph_type"
  else
    error "Failed to delete paragraph type: $paragraph_type"
  fi
done
