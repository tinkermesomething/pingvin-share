#!/bin/bash

# Rebrand script: pingvin-share → tinkerme-share
# Safe to run multiple times on macOS
# Uses sed -i '' for in-place editing (macOS compatible)

set -e

PROJECT_ROOT="/Users/angelsomething/repositories/GITHUB/pingvin-share"
cd "$PROJECT_ROOT"

echo "Starting rebrand: pingvin-share → tinkerme-share"
echo "Project root: $PROJECT_ROOT"
echo ""

# Helper function for sed replacements (macOS compatible)
replace_in_file() {
    local file="$1"
    local pattern="$2"
    local replacement="$3"

    if [[ -f "$file" ]]; then
        sed -i '' "s/${pattern}/${replacement}/g" "$file"
        echo "✓ Updated: $file"
    fi
}

# Find and replace pattern across multiple files
replace_in_files() {
    local pattern="$1"
    local replacement="$2"
    shift 2
    local files=("$@")

    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            sed -i '' "s/${pattern}/${replacement}/g" "$file"
            echo "✓ Updated: $file"
        fi
    done
}

echo "=========================================="
echo "1. Replacing kebab-case: pingvin-share → tinkerme-share"
echo "=========================================="

replace_in_files "pingvin-share" "tinkerme-share" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "scripts/package.json" \
    "README.md" \
    "CHANGELOG.md" \
    "CONTRIBUTING.md" \
    "config.example.yaml" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts" \
    ".github/FUNDING.yml" \
    ".github/workflows/backend-system-tests.yml" \
    ".github/workflows/build-docker-image.yml"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/pingvin-share/tinkerme-share/g" "$file"
    echo "✓ Updated: $file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/pingvin-share/tinkerme-share/g" "$file"
    echo "✓ Updated: $file"
done

echo ""
echo "=========================================="
echo "2. Replacing snake_case: pingvin_share → tinkerme_share"
echo "=========================================="

replace_in_files "pingvin_share" "tinkerme_share" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "scripts/package.json" \
    "README.md" \
    "config.example.yaml" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/pingvin_share/tinkerme_share/g" "$file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/pingvin_share/tinkerme_share/g" "$file"
done

echo ""
echo "=========================================="
echo "3. Replacing display name: Pingvin Share → Tinkerme Share"
echo "=========================================="

replace_in_files "Pingvin Share" "Tinkerme Share" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "README.md" \
    "CHANGELOG.md" \
    "CONTRIBUTING.md" \
    "config.example.yaml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts" \
    "frontend/src/components/footer/Footer.tsx" \
    ".github/FUNDING.yml"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/Pingvin Share/Tinkerme Share/g" "$file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/Pingvin Share/Tinkerme Share/g" "$file"
done

echo ""
echo "=========================================="
echo "4. Replacing no-separator: pingvinshare → tinkermeshare"
echo "=========================================="

replace_in_files "pingvinshare" "tinkermeshare" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "scripts/package.json" \
    "README.md" \
    "config.example.yaml" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/pingvinshare/tinkermeshare/g" "$file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/pingvinshare/tinkermeshare/g" "$file"
done

echo ""
echo "=========================================="
echo "5. Replacing PascalCase: PingvinShare → TinkermeShare"
echo "=========================================="

replace_in_files "PingvinShare" "TinkermeShare" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "scripts/package.json" \
    "README.md" \
    "config.example.yaml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts" \
    ".github/FUNDING.yml"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/PingvinShare/TinkermeShare/g" "$file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/PingvinShare/TinkermeShare/g" "$file"
done

echo ""
echo "=========================================="
echo "6. Replacing GitHub user: stonith404 → tinkermesomething"
echo "=========================================="

replace_in_files "stonith404" "tinkermesomething" \
    "package.json" \
    "backend/package.json" \
    "frontend/package.json" \
    "docs/package.json" \
    "scripts/package.json" \
    "README.md" \
    "CHANGELOG.md" \
    "CONTRIBUTING.md" \
    "config.example.yaml" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "docs/docusaurus.config.ts" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts" \
    "frontend/src/components/footer/Footer.tsx" \
    ".github/FUNDING.yml" \
    ".github/workflows/backend-system-tests.yml" \
    ".github/workflows/build-docker-image.yml"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/stonith404/tinkermesomething/g" "$file"
done

find "$PROJECT_ROOT/frontend/src" -type f \( -name "*.tsx" -o -name "*.ts" \) | while read file; do
    sed -i '' "s/stonith404/tinkermesomething/g" "$file"
done

echo ""
echo "=========================================="
echo "7. Replacing database file: pingvin-share.db → tinkerme-share.db"
echo "=========================================="

replace_in_files "pingvin-share\.db" "tinkerme-share.db" \
    "README.md" \
    "CHANGELOG.md" \
    "config.example.yaml" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "backend/src/constants.ts" \
    "backend/prisma/seed/config.seed.ts"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/pingvin-share\.db/tinkerme-share.db/g" "$file"
done

echo ""
echo "=========================================="
echo "8. Replacing redis service: pingvin-redis → tinkerme-redis"
echo "=========================================="

replace_in_files "pingvin-redis" "tinkerme-redis" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml" \
    "config.example.yaml" \
    "README.md" \
    "CHANGELOG.md" \
    "backend/src/constants.ts"

find "$PROJECT_ROOT/docs/docs" -type f -name "*.md" | while read file; do
    sed -i '' "s/pingvin-redis/tinkerme-redis/g" "$file"
done

echo ""
echo "=========================================="
echo "9. Replacing docs package: pingvindocs → tinkermedocs"
echo "=========================================="

replace_in_files "pingvindocs" "tinkermedocs" \
    "docs/package.json" \
    "docs/docusaurus.config.ts" \
    "docker-compose.yml" \
    "docker-compose.dev.yml" \
    "docker-compose.local.yml"

echo ""
echo "=========================================="
echo "Rebrand complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Review changes: git diff"
echo "2. Test build: npm install && npm run build"
echo "3. Commit: git add . && git commit -m 'rebrand: pingvin-share → tinkerme-share'"
echo ""
