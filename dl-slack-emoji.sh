#!/bin/bash

function usage {
  cat <<USAGE
Usage: dl-slack-emoji.sh project token

  project: https://<project>.slack.com
  token: get one at <https://api.slack.com/docs/oauth-test-tokens>.
USAGE
}

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  usage
  exit
fi

# https://<project>.slack.com
project=$1
# Get a OAuth test token at <https://api.slack.com/docs/oauth-test-tokens>.
token=$2

function getlinks {
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
