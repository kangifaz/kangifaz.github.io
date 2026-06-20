---
date: '2026-06-20T16:19:43+07:00'
draft: false
title: 'Maintain Alexandria'
weight: 1
---

## Overview

Alexandria runs on Hugo with the Hextra theme. Hosted on GitHub Pages. This guide covers the three things you need: download the site, write content, and upload changes.

---

## Prerequisites

Install these once.

| Tool | Why |
|------|-----|
| Hugo Extended | Builds the site. Version `0.140.2`. |
| Git | Tracks changes and pushes to GitHub. |
| Go | Pulls in the Hugo theme module. |

Check versions:

```bash
hugo version
git version
```

---

## 1. Download the Site

### 1.1 First-Time Setup

Clone the repository and pull in the theme.

```bash
git clone git@github.com:<your-username>/<your-repo>.git
cd <your-repo>
hugo mod get
hugo mod tidy
```

### 1.2 Start a New Session

Always pull the latest changes before writing.

```bash
cd <your-repo>
git checkout main
git pull origin main
```

---

## 2. Develop and Preview

### 2.1 Start the Preview Server

```bash
hugo server -D
```

Open `http://localhost:1313`. The page reloads automatically when you save a file.

### 2.2 Project Structure (Simplified)

```
.
├── content/               # Write here
│   ├── _index.md          # Homepage
│   ├── blog/              # Blog posts
│   │   ├── _index.md      # Blog section index
│   │   └── topic-name/
│   │       ├── _index.md  # Topic section index
│   │       └── article-title/
│   │           ├── _index.md  # Article content
│   │           └── img/       # Article images
│   └── docs/              # Documentation pages
│       ├── _index.md      # Docs section index
│       └── topic-name/
│           ├── _index.md  # Topic section index
│           └── article-title/
│               ├── _index.md  # Article content
│               └── img/       # Article images
├── static/
│   └── CNAME             # Custom domain
├── hugo.yaml              # Site config
└── .github/workflows/    # Auto-deploy setup
```

**Never edit the `public/` folder or the `gh-pages` branch.** Both are generated automatically.

---

## 3. Add a New Article

### 3.1 Create the Article File

Use the Hugo command to generate a new content file:

```bash
hugo new content/blog/my-first-article.md
```

**Crucial next step:** Convert the generated file into the required folder structure. Every article must live inside its own folder with an `_index.md` file.

### 3.2 Build the Correct Structure

```bash
# Create the article folder
mkdir -p content/blog/<topic>/<article-title>

# Move the generated Markdown file and rename it
mv content/blog/my-first-article.md content/blog/<topic>/<article-title>/_index.md
```

**Example for a documentation page:**

```bash
hugo new content/docs/my-guide.md
mkdir -p content/docs/<topic>/<article-title>
mv content/docs/my-guide.md content/docs/<topic>/<article-title>/_index.md
```

**Final structure for every article:**

```
content/
└── blog/
    └── <topic>/
        └── <article-title>/
            ├── _index.md
            └── img/           # Optional: images for the article
```

### 3.3 Add Images

Create an `img/` folder next to your `_index.md`.

```bash
mkdir content/blog/<topic>/<article-title>/img
```


### 3.4 Write the Front Matter

Every `_index.md` needs this at the top.

```yaml
---
title: "Your Title"
date: 2026-06-20
draft: false
categories:
  - Category
tags:
  - tag1
  - tag2
---
```

Set `draft: true` to hide the page from production. Preview with `hugo server -D`.

---

## 4. Continue Development

### 4.1 Edit Existing Content

Navigate to the article folder and edit the `_index.md` file directly. The preview server reloads automatically.

### 4.2 Update the Menu

Edit `hugo.yaml` to add a new menu item.

```yaml
menu:
  main:
    - name: "My New Section"
      url: "/blog/my-topic/"
      weight: 5
    - name: Search
      weight: 6
      params:
        type: search
```

### 4.3 Update the Theme

Hextra is loaded via Hugo modules. To update:

```bash
hugo mod get -u github.com/imfing/hextra
hugo mod tidy
git add go.mod go.sum
git commit -m "Update Hextra theme"
```

---

## 5. Upload Changes

Three commands. Every time.

```bash
git add .
git commit -m "Describe what you changed"
git push origin main
```

The site deploys automatically. Check the status under the **Actions** tab on GitHub. A green checkmark means it is live.

---

## 6. Switch Devices

**Before switching, push from the current device.**

```bash
git push origin main
```

**On the other device, pull.**

```bash
git pull origin main
hugo server -D
```

---

## 7. Quick Reference

| Command | What it does |
|---------|--------------|
| `git pull origin main` | Download latest content |
| `hugo server -D` | Preview the site locally |
| `hugo new content/blog/article-name.md` | Generate a new page file |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Save changes locally |
| `git push origin main` | Upload to GitHub |
| `hugo mod get` | Download theme modules |
| `hugo --minify` | Build site for production |

---

## 8. FAQ

### What is the difference between `_index.md` and a regular `.md` file?

An `_index.md` represents a section or a page that can have children. Every folder that should be a browsable page needs one. Regular `.md` files are standalone pages without children. Alexandria uses `_index.md` inside folders for everything.

### Why does every article need its own folder?

It keeps images and supporting files organized. Each article folder contains the Markdown content plus an `img/` directory for screenshots and diagrams. This prevents a messy, flat file structure.

### How do I rename an article?

Rename the article folder. The URL will change accordingly. If you want to keep the old URL working, add an alias in the front matter:

```yaml
aliases:
  - /old-url/
```

### Can I write a single Markdown file without a folder?

Yes, Hugo supports `content/blog/single-page.md`. However, Alexandria uses the folder structure with `_index.md` for all content to keep images and related files organized.

### What happens if I push while the preview server is running?

Nothing. The preview server watches the `content/` folder. Git commands run independently and do not interfere.

---

## 9. Troubleshooting

### Site not updating?

Open the **Actions** tab on GitHub. If the latest run is red, click it and read the error. Fix the problem and push again.

### Build fails locally?

```bash
hugo mod clean
hugo mod get
hugo --minify
```

### Page returns 404?

- Check the URL matches the folder name exactly.
- Make sure the folder contains `_index.md`.
- Trigger a rebuild:

```bash
git commit --allow-empty -m "Trigger rebuild"
git push origin main
```

### Hugo version mismatch?

Update the version in `.github/workflows/hugo-deploy.yml`.

```yaml
- name: Setup Hugo
  uses: peaceiris/actions-hugo@v2
  with:
    hugo-version: '0.140.2'
    extended: true
```

### Theme not loading?

```bash
hugo mod clean
hugo mod get github.com/imfing/hextra@v0.9.3
hugo mod tidy
```

---

*Last updated: June 20, 2026*