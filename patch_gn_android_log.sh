#!/bin/bash

# Find all GN build files
find . -type f \( -name 'BUILD.gn' -o -name '*.gn' -o -name '*.gni' \) | while read file; do
  # Patch for licenses_cpp target
  if grep -q 'licenses_cpp' "$file"; then
    if ! grep -q 'libs += [ "log" ]' "$file"; then
      echo "Patching $file for licenses_cpp..."
      sed -i '/licenses_cpp.*{/a\
if (is_android) {\
  libs += [ "log" ]\
}' "$file"
    fi
  fi

  # Patch for licenses_cpp_testrunner target
  if grep -q 'licenses_cpp_testrunner' "$file"; then
    if ! grep -q 'libs += [ "log" ]' "$file"; then
      echo "Patching $file for licenses_cpp_testrunner..."
      sed -i '/licenses_cpp_testrunner.*{/a\
if (is_android) {\
  libs += [ "log" ]\
}' "$file"
    fi
  fi
done

echo "Patch complete!"