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

### Configure Separator

By default, slugs use `-` as the separator. You can change this with `SLUGIFY_SEPARATOR`:

```zsh
export SLUGIFY_SEPARATOR="_"
slugify "Hello World"
# Outputs: hello_world
```

### Keep Original Case

By default, output is lowercased. To keep original letter case, set `SLUGIFY_KEEP_CASE`:

```zsh
export SLUGIFY_KEEP_CASE=1
slugify "Hello World"
# Outputs: Hello-World
```

### Slugify a File Name

Rename a single file to a slugified name while keeping its extension:

```bash
slugify-file "My Report 2026.pdf"
# Renames to: my-report-2026.pdf
```

Alias:

```bash
slugifyf "My Report 2026.pdf"
```

### Slugify All Files in a Directory

Slugify all regular files in one directory (non-recursive):

```bash
slugify-dir .
```

Alias:

```bash
slugifyd .
```

## Features

- Converts text to lowercase by default (optional case preservation)
- Removes special characters and accents (ASCII transliteration)
- Replaces spaces and special characters with a configurable separator
- Strips leading/trailing separators
- Works with piped input or command arguments
- Supports file renaming with `slugify-file` / `slugifyf`
- Supports batch directory renaming with `slugify-dir` / `slugifyd`
