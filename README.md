# dotfiles

## 1. Setup Homebrew

```sh-session
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Install packages

```sh-session
brew bundle --global --file /PATH/TO/dot_Brewfile
```

## 3. Init dotfiles w/ chezmoi

```sh-session
chezmoi init --apply --ssh hayajo
```

Please refer to [Daily operations \- chezmoi](https://www.chezmoi.io/user-guide/daily-operations/) for further operations.
