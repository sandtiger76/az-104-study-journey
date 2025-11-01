#!/bin/bash

# List of groups to create
groups=(
  "Gryffindor Students"
  "Slytherin Students"
  "Ravenclaw Students"
  "Hufflepuff Students"
  "Hogwarts Staff"
)

# Loop through each group and create it
for group in "${groups[@]}"
do
  echo "Creating group: $group"
  az ad group create --display-name "$group" --mail-nickname "${group// /}" 2>/dev/null
done
