# zsh-slugify

A lightweight zsh plugin for converting text into URL-friendly slugs.

## Installation

This plugin is part of your oh-my-zsh custom plugins. To enable it, add `zsh-slugify` to your `plugins` array in `~/.zshrc`:

```zsh
plugins=(... zsh-slugify)
```

## Usage

### Basic Usage

Convert text to a slug:

```bash
slugify "Hello World"
# Outputs: hello-world

slugify "Ä fancy café résumé!"
# Outputs: a-fancy-cafe-resume
```

### Pipe Input

Use with pipes or as part of a shell pipeline:

```bash
echo "Convert This Text" | slugify
# Outputs: convert-this-text

cat myfile.txt | slugify
```

## Features

- Converts text to lowercase
- Removes special characters and accents (ASCII transliteration)
- Replaces spaces and special characters with hyphens
- Strips leading/trailing hyphens
- Works with piped input or command arguments
