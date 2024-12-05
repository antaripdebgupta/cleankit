#!/bin/bash

react_files=("src/App.css" "src/App.test.js" "src/logo.svg" "src/reportWebVitals.js" "src/setupTests.js")

# Function to remove React boilerplate files
remove_react_files() {
  local path=$1

  for file in "${react_files[@]}"; do
    target="$path/$file"
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Removed: $file"
    else
      echo "Already removed: $file"
    fi
  done
}

# Function to clean React App.js and index.js
clean_react_file() {
  local project_dir=$1
  local app_file="$project_dir/src/App.js"
  local index_file="$project_dir/src/index.js"

  if [[ -f "$app_file" ]]; then
  # Remove specific import statements
  sed -i "/import logo from '.\/logo.svg';/d" "$app_file"
  sed -i '/import logo from ".\/logo.svg";/d' "$app_file"
  sed -i "/import '.\/App.css';/d" "$app_file"
  sed -i '/import ".\/App.css";/d' "$app_file"

    # Check if the <div> block is already cleaned
    if ! grep -q '<div></div>' "$app_file"; then
          # Remove everything inside the return statement and replace with <div></div>
          sed -i '/return (/,/);/c\  return (\n    <div></div>\n  );' "$app_file"
          echo "Cleaned: $app_file"
      else
          echo "$app_file is already cleaned."
      fi
  else
    echo "App.js file not found in $project_dir/src/"
  fi

  if [[ -f "$index_file" ]]; then
    # Check if the file needs cleaning by searching for the specific lines
    if grep -q "import reportWebVitals from '.\/reportWebVitals';" "$index_file" || \
       grep -q 'import reportWebVitals from ".\/reportWebVitals";' "$index_file" || \
       grep -q 'reportWebVitals();' "$index_file"; then
        sed -i "/import reportWebVitals from '.\/reportWebVitals';/d" "$index_file"
        sed -i '/import reportWebVitals from ".\/reportWebVitals";/d' "$index_file"
        sed -i '/reportWebVitals();/d' "$index_file"
        echo "Cleaned: $index_file"
    else
        echo "index.js is already cleaned."
    fi
  elif [[ -f "$project_dir/src/index.js" ]]; then
      echo "index.js is already clean."
  else
      echo "index.js file not found in $project_dir/src/"
  fi
}

# Function to prompt the user to update meta information
update_meta_info() {
  local html_file="$1/public/index.html"

  if [[ ! -f "$html_file" ]]; then
    echo "Error: HTML file not found at $html_file. Skipping title update."
    return 1
  fi

  echo "HTML file detected: $html_file"

  current_title=$(grep -oP '(?<=<title>).*?(?=</title>)' "$html_file" || echo "N/A")
  echo "Current Title: $current_title"

  read -p "Would you like to update the title? (yes/no): " update_title
  if [[ "$update_title" != "yes" ]]; then
    echo "Title left unchanged."
    return 0
  fi

  read -p "Enter new title (leave blank to keep current): " new_title

  if [[ -n "$new_title" ]]; then
    sed -i "s|<title>.*</title>|<title>$new_title</title>|" "$html_file"
    echo "Title updated to: $new_title"
  else
    echo "Title left unchanged."
  fi

  return 0
}

