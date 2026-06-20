# Hugo Blog Restructuring - Setup Guide

## **New Unified Workflow**

### **Local Development Workflow**

```bash
# 1. Pull latest changes
git pull origin gh-pages

# 2. Create/update blog content in /content directory
# Edit files in: content/blog/, content/docs/, etc.

# 3. Build Hugo locally (with drafts)
hugo server -D

# 4. Preview at http://localhost:1313

# 5. Generate production build (no drafts)
hugo

# 6. Stage all changes (source + generated public/)
git add .

# 7. Commit with meaningful message
git commit -m "Update: Add new blog post about X"

# 8. Push everything to gh-pages branch
git push origin gh-pages
```

### **GitHub Pages Configuration Steps**

1. **Go to Repository Settings**
   - Navigate to: `https://github.com/kangifaz/kangifaz.github.io/settings`

2. **Find "Pages" section** (left sidebar)
   - Build and deployment section

3. **Configure source:**
   - **Source:** Deploy from a branch
   - **Branch:** `gh-pages`
   - **Folder:** `/ (root)` ← **IMPORTANT**: Change this to `/public` if available
   
   *Note: If `/public` isn't available as option, you need to:*
   - Wait for GitHub Actions integration
   - Or use GitHub Actions workflow (see below)

### **Alternative: GitHub Actions Setup** (Recommended)

Create `.github/workflows/hugo.yml`:

```yaml
name: Deploy Hugo Site

on:
  push:
    branches: [gh-pages]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: latest
          extended: true
      
      - name: Build
        run: hugo --minify
      
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
          cname: kangifaz.com
```

## **Directory Structure**

```
kangifaz.github.io/
├── .git
├── .github/
│   └── workflows/
│       └── hugo.yml           # GitHub Actions (optional)
├── .gitignore                 # NEW - tracks public/
├── content/                   # Source content
│   ├── blog/
│   ├── docs/
│   └── _index.md
├── public/                    # NEW - now tracked in git
│   ├── index.html
│   ├── blog/
│   ├── docs/
│   └── ...
├── archetypes/
├── layouts/
├── static/
├── hugo.yaml                  # Hugo config
└── go.mod
```

## **First-Time Pushes After Migration**

```bash
# After building with: hugo
# Stage everything including public/
git add public/

# Commit sources + generated files
git commit -m "Initial commit: Restructure for unified workflow"

# Push to gh-pages
git push origin gh-pages --force

# Only use --force once; after that use normal push
```

## **Benefits of New Setup**

✅ Single repository (no sync issues)  
✅ One workflow: pull → edit → build → push  
✅ Easy device switching (just `git pull`)  
✅ Full history of generated files  
✅ Simpler CI/CD integration  

## **Pro Tips**

1. **Avoid editing `public/` directly** - always regenerate with Hugo
2. **Use `.gitkeep`** in empty directories if needed:
   ```bash
   touch public/.gitkeep
   ```
3. **Large repository**: Consider using [git-lfs](https://git-lfs.com/) for image assets
4. **Automate builds**: Use GitHub Actions to auto-build on commits to `content/`

## **Troubleshooting**

**Q: GitHub Pages still shows old domain?**  
A: CNAME file in public/ should contain: `kangifaz.com`

**Q: Can't select `/public` in Pages settings?**  
A: Use GitHub Actions workflow instead (more flexible)

**Q: Public folder too large?**  
A: Add media to `static/` instead, kept separate from `public/`
