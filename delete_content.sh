#!/bin/bash

# Lista de tipos de conteúdo a serem deletados
content_types=(
  "code_of_ethics_homepage"
  "code_of_ethics_identity_trait"
  "code_of_ethics_subject"
  "custom_widget"
  "edpon_magazine"
  #"events" - Continha registos mas não foi listado no log, portanto talvez não seja preciso deletar.
  #"hint" - Continha registos mas não foi listado no log, portanto talvez não seja preciso deletar.
  "infospot"
  "infospot_accordions"
  "infospot_faq"
  "infospot_index"
  "infospot_macro_activities"
  "infospot_procedures"
  "infospot_tabs"
  "installation"
  "landing_page"
  # "news" - Continha registos mas não foi listado no log, portanto talvez não seja preciso deletar.
  "news_comments"
  # "page" - Continha registos mas não foi listado no log, portanto talvez não seja preciso deletar.
  "person"
  "person_aboutme"
  "person_iam"
  "person_pictures"
  "process"
  "resources_page"
  "tool"
  "video"
  "webform"
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

# Função para deletar conteúdos
delete_content() {
  local content_type=$1
  if [ "$content_type" = "news_comments" ]; then
    info "Deleting content of type: $content_type using direct SQL"
    # Comandos SQL para deletar o conteúdo de news_comments
    lando drush sql:query "
    -- Selecionar todos os nids para o tipo de conteúdo 'news_comments'
    SET @nids = (SELECT GROUP_CONCAT(nid) FROM node WHERE type = 'news_comments');

    -- Deletar da tabela node_field_data
    DELETE FROM node WHERE type = 'news_comments';

    -- Deletar da tabela node_revision usando os nids
    DELETE FROM node_revision WHERE nid IN (@nids);

    -- Deletar da tabela node__field_data usando os nids
    DELETE FROM node__body WHERE entity_id IN (@nids);
    DELETE FROM node__field_comment_first_level WHERE entity_id IN (@nids);
    DELETE FROM node__field_comment_quote WHERE entity_id IN (@nids);
    DELETE FROM node__field_comment_reply WHERE entity_id IN (@nids);
    DELETE FROM node__field_comment_status WHERE entity_id IN (@nids);
    DELETE FROM node__field_comment_type WHERE entity_id IN (@nids);
    DELETE FROM node__field_image_attached WHERE entity_id IN (@nids);
    DELETE FROM node__field_news WHERE entity_id IN (@nids);

    SET FOREIGN_KEY_CHECKS = 1;
    "
    if [ $? -eq 0 ]; then
      success "Deleted content of type: $content_type using direct SQL"
    else
      error "Failed to delete content of type: $content_type using direct SQL"
    fi
  else
    info "Deleting content of type: $content_type"
    lando drush entity:delete node --bundle=$content_type
    if [ $? -eq 0 ]; then
      success "Deleted content of type: $content_type"
    else
      error "Failed to delete content of type: $content_type"
    fi
  fi
}

# Loop através dos tipos de conteúdo e deletar os conteúdos
for content_type in "${content_types[@]}"; do
  delete_content $content_type
done

success "All specified content types have been deleted."
