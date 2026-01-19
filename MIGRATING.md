# Migrating from Pingvin Share to Tinkerme Share

This document covers migration from the original Pingvin Share or previous versions of Tinkerme Share.

## For Pingvin Share users

If you were running the original `stonith404/pingvin-share`, here's what you need to know:

### Docker Image

**Old image:**
```yaml
image: stonith404/pingvin-share
# or
image: ghcr.io/stonith404/pingvin-share
```

**New image:**
```yaml
image: tinkermesomething/tinkerme-share
# or
image: ghcr.io/tinkermesomething/tinkerme-share
```

### Database

The database filename has changed from `pingvin-share.db` to `tinkerme-share.db`.

**For existing installations:**

Option 1 - Rename your database file:
```bash
cd ./data
mv pingvin-share.db tinkerme-share.db
```

Option 2 - Set the `DATABASE_URL` environment variable:
```yaml
environment:
  - DATABASE_URL=file:../data/pingvin-share.db?connection_limit=1
```

### Redis (if using)

If you're using Redis caching, update your Redis URL:

**Old:**
```yaml
redis://pingvin-redis:6379
```

**New:**
```yaml
redis://tinkerme-redis:6379
```

Or rename your Redis service in docker-compose to `tinkerme-redis`.

### Config File

If using `config.yaml`, no changes are required - the configuration format is identical.

### Data Volumes

Data volume paths remain unchanged:
- `./data:/opt/app/backend/data`
- `./data/images:/opt/app/frontend/public/img`

Your uploaded files and shares will continue to work.

## Breaking Changes Summary

| Item | Old | New |
|------|-----|-----|
| Docker image | `stonith404/pingvin-share` | `tinkermesomething/tinkerme-share` |
| GHCR image | `ghcr.io/stonith404/pingvin-share` | `ghcr.io/tinkermesomething/tinkerme-share` |
| Database file | `pingvin-share.db` | `tinkerme-share.db` |
| Redis host | `pingvin-redis` | `tinkerme-redis` |
| Service name | `pingvin-share` | `tinkerme-share` |

## Need Help?

Open an issue at: https://github.com/tinkermesomething/tinkerme-share/issues
