#!/bin/bash

# Use your verified Azure AD domain
domain="yourdomain"

# Default password for all users
password="P@ssword123!"

# Declare associative array of users and their groups
declare -A users_groups=(
  ["hermione.granger"]="Gryffindor Students"
  ["ron.weasley"]="Gryffindor Students"
  ["draco.malfoy"]="Slytherin Students"
  ["luna.lovegood"]="Ravenclaw Students"
  ["neville.longbottom"]="Gryffindor Students"
  ["ginny.weasley"]="Gryffindor Students"
  ["cho.chang"]="Ravenclaw Students"
  ["cedric.diggory"]="Hufflepuff Students"
  ["severus.snape"]="Hogwarts Staff"
  ["minerva.mcgonagall"]="Hogwarts Staff"
  ["albus.dumbledore"]="Hogwarts Staff"
)

# Step 1: Ensure all groups exist
for group in "${users_groups[@]}"
do
  echo "Ensuring group exists: $group"
  az ad group create --display-name "$group" --mail-nickname "${group// /}" 2>/dev/null
done

# Step 2: Create users and add them to groups
for username in "${!users_groups[@]}"
do
  upn="${username}@${domain}"
  display_name="$(echo $username | sed 's/\./ /g')"
  mail_nickname="${username//./}"
  group="${users_groups[$username]}"

  echo "Creating user: $upn"
  az ad user create \
    --display-name "$display_name" \
    --user-principal-name "$upn" \
    --password "$password" \
    --mail-nickname "$mail_nickname" \
    --force-change-password-next-sign-in

  # Get user and group IDs
  user_id=$(az ad user show --id "$upn" --query id -o tsv 2>/dev/null)
  group_id=$(az ad group show --group "$group" --query id -o tsv 2>/dev/null)

  if [[ -n "$user_id" && -n "$group_id" ]]; then
    echo "Adding $upn to group: $group"
    az ad group member add --group "$group" --member-id "$user_id"
  else
    echo "⚠️ Skipping group assignment for $upn due to missing user or group."
  fi
done
