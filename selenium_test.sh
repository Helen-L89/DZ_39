#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <stand_url> <browser_name> <browser_version>"
  exit 1
fi

stand_url="$1"
browser_name="$2"
browser_version="$3"

cat >test_script.py <<EOF
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

caps = DesiredCapabilities.$(echo "$browser_name" | tr '[:lower:]' '[:upper:]')
caps['browserVersion'] = '$browser_version'
caps['selenoid:options'] = {'enableVNC': True, 'enableVideo': False}

driver = webdriver.Remote(command_executor='http://localhost:4444/wd/hub', desired_capabilities=caps)
try:
    driver.get('$stand_url')
    print("Page title:", driver.title)
finally:
    driver.quit()
EOF

python3 test_script.py
