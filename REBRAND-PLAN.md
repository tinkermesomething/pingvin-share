# Rebrand Plan: pingvin-share → tinkerme-share

## Status: PENDING (documented for next session)

## Overview
Rebrand the forked project from "Pingvin Share" to "Tinkerme Share" to differentiate from the archived original.

---

## Phase 1: GitHub Changes (Manual)

### 1.1 Rename Repository
- Go to: https://github.com/tinkermesomething/pingvin-share/settings
- Change "Repository name" to `tinkerme-share`
- Do this AFTER code changes are pushed

### 1.2 Update Local Remote
```bash
git remote set-url origin https://github.com/tinkermesomething/tinkerme-share.git
```

### 1.3 Docker Hub
- Create new repo `tinkermesomething/tinkerme-share` OR
- Rename existing if possible

### 1.4 Wiki Migration
- Check if original wiki is clonable: `git clone https://github.com/stonith404/pingvin-share.wiki.git`
- If yes, push to new repo's wiki
- If no (archived), manually recreate key pages

### 1.5 GitHub Pages for Docs
- Enable GitHub Pages on new repo
- Update docusaurus.config.ts with new URLs

---

## Phase 2: Code Changes (Surgical, not blind sed)

### 2.1 SAFE TO RENAME (do these)

| File | Change |
|------|--------|
| `package.json` | name: "pingvin-share" → "tinkerme-share" |
| `backend/package.json` | name: "pingvin-share-backend" → "tinkerme-share-backend" |
| `frontend/package.json` | name: "pingvin-share-frontend" → "tinkerme-share-frontend" |
| `docs/package.json` | name: "pingvindocs" → "tinkermedocs" |
| `docker-compose.yml` | service name, image reference |
| `docker-compose.*.yml` | same as above |
| `backend/src/constants.ts` | database filename |
| `backend/prisma/seed/config.seed.ts` | default app name, email templates |
| `config.example.yaml` | app name, redis service name |
| `docs/docusaurus.config.ts` | title, URLs, project name |
| `.github/workflows/*.yml` | image references if hardcoded |

### 2.2 NEEDS CAREFUL HANDLING

| File | Issue |
|------|-------|
| `README.md` | Keep attribution to original, remove broken demo link, update image refs |
| `CHANGELOG.md` | Keep historical references to stonith404 commits |
| `CONTRIBUTING.md` | Update clone URLs but keep credit |
| `docs/docs/*.md` | Update URLs to new repo, remove dead links |
| `frontend/src/pages/admin/intro.tsx` | Remove sponsor link, update GitHub link |
| `frontend/src/components/footer/Footer.tsx` | Update GitHub link |
| `frontend/src/services/config.service.ts` | Update GitHub API URL for version check |
| `.github/FUNDING.yml` | Remove or update to your own sponsors |

### 2.3 DO NOT CHANGE

| Reference | Reason |
|-----------|--------|
| `stonith404/pocket-id` | Different project, not ours |
| `pingvin-share.dev.eliasschneider.com` | Original author's demo - REMOVE don't rebrand |
| `crowdin.com/project/pingvin-share` | We don't own that Crowdin project - REMOVE |
| `github.com/sponsors/stonith404` | Wrong person - REMOVE |
| Historical commit references in CHANGELOG | Preserve history |

### 2.4 TRANSLATION FILES (~30 files)
Location: `frontend/src/i18n/translations/*.ts`

Need to update "Pingvin Share" display name in all language files. Handle with:
```bash
find frontend/src/i18n/translations -name "*.ts" -exec grep -l "Pingvin Share" {} \;
```

### 2.5 ASSET FILES TO RENAME

| From | To |
|------|-----|
| `docs/static/img/pingvinshare.svg` | `docs/static/img/tinkermeshare.svg` |
| Update references in `docs/docusaurus.config.ts` | |

Note: Logo image itself can stay (penguin) or be replaced later.

---

## Phase 3: Migration Notes for Existing Users

Create `MIGRATING.md` with:
- Database file location unchanged (backward compat)
- Docker image name change
- Config file compatibility

---

## Phase 4: Post-Rebrand

1. Commit all changes
2. Rename repo on GitHub
3. Update local remote
4. Create new release (v1.15.0 or v2.0.0?)
5. Push new Docker images with new name
6. Update .work-tracker.json

---

## Files Changed by Security Work (already done)

For reference, these files were modified in v1.14.0:
- `backend/src/file/file.service.ts` - sanitizeFileName()
- `backend/src/file/file.service.spec.ts` - unit tests
- `backend/src/oauth/oauth.controller.ts` - cookie hardening
- `backend/src/config/config.controller.ts` - FileTypeValidator fix
- `backend/package.json` - jest, nodemailer upgrade
- `frontend/package.json` - security updates
- Various package-lock.json files

---

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Package.json renames | 90% | Straightforward |
| Docker references | 85% | Need backward compat note |
| README/docs | 70% | Manual review required |
| Translation files | 80% | Tedious but safe |
| Wiki migration | 30% | Depends on archive status |
| Overall | 75% | With surgical approach |

---

## Next Session Checklist

- [ ] Start with Phase 2.1 (safe renames)
- [ ] Then Phase 2.2 (careful handling)
- [ ] Skip Phase 2.3 items
- [ ] Handle translations
- [ ] Rename asset files
- [ ] Test build
- [ ] Commit
- [ ] Then do Phase 1 GitHub changes
