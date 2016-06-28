# Download your Slack emojis.

```bash
./dl-slack-emoji.sh project token
```

*Inputs:*

- `project`: If your project lives at <https://my-project.slack.com>, it would be `my-project`.
- `token`: Generate a token at <https://api.slack.com/docs/oauth-test-tokens>.

*Output:* an `emoji/` folder in the current directory, containing all the images
corresponding to the custom emojis that you have available in the project.
