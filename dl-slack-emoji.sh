#!/bin/bash

# https://<project>.slack.com
project=$1
# Get a OAuth test token at <https://api.slack.com/docs/oauth-test-tokens>.
token=$2

getlinks() {
  curl "https://$project.slack.com/api/emoji.list" -d token="$token" |
  jq .emoji[] |
  grep https |
  sed 's,^"\(.*\)"$,\1,'
}

mkdir emoji
for link in $(getlinks); do
  # Images are of the form <https://…/name/1234.png>.
  name=$(echo "$link" | sed 's,^.*/\([^/]*\)/[^/]*$,\1,')
  ext=$(echo "$link" | grep -o '\.[^\.]*$')
  curl "$link" > emoji/"$name$ext"
done
