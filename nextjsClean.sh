#!/bin/bash

files=("public/next.svg" "public/vercel.svg" "public/file.svg" "public/window.svg" "public/globe.svg")

# Function to remove Next.js boilerplate files
remove_nextjs_files() {
  local path=$1

  for file in "${files[@]}"; do
    target="$path/$file"
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Removed: $file"
    else
      echo "Already removed: $file"
    fi
  done
}

# Function to clean Next.js page.js
clean_nextjs_file() {
  local project_dir=$1
  local app_file_1="$project_dir/app/page.js"
  local app_file_2="$project_dir/src/app/page.js"
  local app_file_3="$project_dir/app/page.tsx"
  local app_file_4="$project_dir/src/app/page.tsx"

  # Array of possible file paths
  local files=("$app_file_1" "$app_file_2" "$app_file_3" "$app_file_4")

  # Loop through each file path
  for app_file in "${files[@]}"; do
    if [[ -f "$app_file" ]]; then
      # Remove specific import statements
      sed -i "/import Image from 'next\/image';/d" "$app_file"
      sed -i '/import Image from "next\/image";/d' "$app_file"

      # Check if the <div></div> structure is already present
      if ! grep -q '<div></div>' "$app_file"; then
          # Remove everything inside the return statement and replace with <div></div>
          sed -i '/return (/,/);/c\  return (\n    <div></div>\n  );' "$app_file"
          echo "Cleaned: $app_file"
      else
          echo "$app_file is already cleaned."
      fi
    else
      echo "$app_file not found."
    fi
  done
}

update_nextjs_meta_info() {
  local project_dir="$1"
  local layout_file1="$project_dir/app/layout.js"
  local layout_file2="$project_dir/src/app/layout.js"
  local layout_file3="$project_dir/app/layout.tsx"
  local layout_file4="$project_dir/src/app/layout.tsx"
  
  # Check if any of the layout files exist
  if [[ -f "$layout_file1" ]]; then
    local layout_file="$layout_file1"
  elif [[ -f "$layout_file2" ]]; then
    local layout_file="$layout_file2"
  elif [[ -f "$layout_file3" ]]; then
    local layout_file="$layout_file3"
  elif [[ -f "$layout_file4" ]]; then
    local layout_file="$layout_file4"
  else
    echo "Error: layout.js not found in either app or src/app folder. Skipping metadata update."
    return 1
  fi

  echo "layout.js file detected: $layout_file"

  # Check if metadata exists in the layout file
  if grep -q 'title: ' "$layout_file"; then
    read -p "Would you like to update the meta information? (yes/no): " update_meta
    if [[ "$update_meta" == "yes" ]]; then
      # Prompt for the new title and description
      read -p "Enter new title (leave blank to keep current): " new_title
      read -p "Enter new description (leave blank to keep current): " new_description

      # Update title if a new title is provided
      if [[ -n "$new_title" ]]; then
        sed -i "s/title: \".*\"/title: \"$new_title\"/" "$layout_file"
        echo "Title updated to: $new_title"
      else
        echo "Title left unchanged."
      fi

      # Update description if a new description is provided
      if [[ -n "$new_description" ]]; then
        sed -i "s/description: \".*\"/description: \"$new_description\"/" "$layout_file"
        echo "Description updated to: $new_description"
      else
        echo "Description left unchanged."
      fi
    else
      echo "Meta information left unchanged in $layout_file."
    fi
  else
    echo "No metadata found in $layout_file. Skipping update."
  fi
}

