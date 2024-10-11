#!/bin/bash

# Lista de tipos de parágrafos a serem deletados
paragraph_types=(
  "",
  ""
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
