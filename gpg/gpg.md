# gpg

* [Issues](#issues)

## Issues

```gpg
// To fix `error: gpg failed to sign the data fatal: failed to write commit object`
brew upgrade gnupg  # This has a make step which takes a while
brew link --overwrite gnupg
brew install pinentry-mac
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
```