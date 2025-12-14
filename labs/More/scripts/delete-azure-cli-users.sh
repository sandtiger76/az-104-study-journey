#!/bin/bash

# Define domain
domain="yourdomain"

# List of users to delete (created via Azure CLI)
users=(
  "hermione.granger"
  "ron.weasley"
  "draco.malfoy"
  "luna.lovegood"
  "neville.longbottom"
  "ginny.weasley"
  "cho.chang"
  "cedric.diggory"
  "severus.snape"
  "minerva.mcgonagall"
  "albus.dumbledore"
)

# Loop through users and delete each one
for user in "${users[@]}"
do
  upn="${user}@${domain}"
  echo "Deleting user: $upn"
  az ad user delete --id "$upn"
done
``
