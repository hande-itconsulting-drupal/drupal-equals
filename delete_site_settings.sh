#!/bin/bash

# Nome correto da entidade "Site Setting"
entity_type="site_setting_entity"

# Array de tipos de "Site Setting" a ser deletado
site_setting_types=(
    "aboutme_blacklist" #AboutME Blacklist
    "banner_feed" #Banner Feed
    "chat_call_settings" #Chat&Call Settings
    "chatbot_settings" #Chatbot Settings
    "code_of_ethics_title" #Code of Ethics
    "edpon" #edpON TV
    "facebook_workplace" #Facebook Workplace
    "first_login_video" #Pop-up
    "information" #Information Widget
    "magazine" #Magazine
    "mails_report" #Mails Report
    "redirect_employee_app" #Redirect Employee App
    "solidary_widget" #Solidary Widget
    "user_preferences" #User Preferences
    "widgets_default" #Widgets Default
)

# Loop através de cada tipo de "Site Setting", deletar as entidades associadas
for type in "${site_setting_types[@]}"; do
  echo "Deleting site setting entities of type: $type"
  lando drush entity:delete $entity_type --bundle="$type"
done

echo "All specified site setting entities have been deleted."
