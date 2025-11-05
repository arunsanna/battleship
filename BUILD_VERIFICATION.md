# Build Verification Guide

## Current Status

All Dockerfiles have been updated with latest versions and the CI/CD pipeline has been configured with intelligent path-based triggers.

## How to Trigger and Monitor Builds

### Option 1: Manual Workflow Dispatch (Recommended for Testing)

1. **Go to GitHub Actions:**
   ```
   https://github.com/arunsanna/battleship/actions
   ```

2. **Select "build-on-demand" workflow** (left sidebar)

3. **Click "Run workflow"** button (top right)

4. **Select a container to test:**
   - Start with simple ones: `alfa`, `kustomize`, `terraform`
   - Then try: `diagnostics`, `network`, `terragrunt`
   - Finally test: UBI images (require specific build order)

5. **Monitor the build:**
   - Click on the running workflow
   - Watch real-time logs for each step
   - Check for errors in build/scan phases

### Option 2: Test via Pull Request

1. **Create PR from feature branch to master:**
   ```bash
   # From GitHub UI:
   https://github.com/arunsanna/battleship/pull/new/claude/code-review-011CUqLy4NZdubvimiLTpx6r
   ```

2. **PR will trigger validation builds** (doesn't push to registry)
   - All changed containers will build in parallel
   - Hadolint validation runs
   - Trivy security scans run
   - Results appear in PR checks

### Option 3: Merge to Master (Production Builds)

Once PR is approved and merged:
- Only changed containers will build and push to DockerHub
- Security scans upload to GitHub Security tab
- Build artifacts cached for faster subsequent builds

## Build Order Dependencies

Some containers depend on others. Build in this order if doing manually:

```
1. ubi-8-standard        (base for many others)
2. ubi-8-fips           (depends on ubi-8-standard)
   ubi-8-micro          (depends on ubi-8-standard)
   ubi-8-minimal        (depends on ubi-8-standard)
3. terraform            (depends on ubi-8-standard)
4. terragrunt           (depends on terraform)
5. diagnostics          (depends on ubi-8-standard)
6. alfa                 (independent)
   cuda                 (independent - may need config files)
   kustomize            (independent)
   network              (independent)
```

## Expected Build Times

- **alfa:** ~3-5 min (Node.js install)
- **cuda:** ~5-8 min (CUDA base is large)
- **diagnostics:** ~8-12 min (many tools to download)
- **kustomize:** ~2-4 min (simple Go build)
- **network:** ~6-10 min (many packages)
- **terraform:** ~2-3 min (binary copy)
- **terragrunt:** ~3-4 min (download + verify)
- **ubi-8-standard:** ~10-15 min (many STIG scripts)
- **ubi-8-fips/micro/minimal:** ~3-5 min each

## Known Potential Issues to Watch For

### 1. Terragrunt SHA256 Mismatch
**File:** `terragrunt/Dockerfile:14`
```
ARG TERRAGRUNT_SHA256=999339e725e4b50ac421502f5ea94e6634e543bc4d8320e8cc7f3c91d5a0d6e8
```
**Fix:** Verify SHA256 from official release page if build fails

### 2. CUDA Missing Files
**Files needed in `cuda/` directory:**
- `config.toml.tmpl`
- `device-plugin-daemonset.yaml`

**Check:** `ls -la cuda/`

### 3. Network Container ZSH Installation
**File:** `network/Dockerfile:88`
- Downloads oh-my-zsh install script
- May fail if GitHub is slow/down
- Non-critical, container will still work

### 4. UBI Base Image Dependencies
**Files:** `diagnostics/`, `terraform/`, `terragrunt/`, `ubi-8-fips/`
- All depend on `ubi-8-standard` being available
- Must build `ubi-8-standard` first

## Monitoring Commands

If you have CLI access:

```bash
# List workflows
gh workflow list

# Watch a specific run
gh run watch <run-id>

# View recent runs
gh run list --limit 10

# Trigger manual build
gh workflow run build-on-demand -f name=alfa

# Check specific container build
gh workflow run build-on-demand -f name=diagnostics
```

## Success Criteria

✅ **Build succeeds:** Green checkmark in Actions
✅ **No Hadolint warnings:** Dockerfile best practices followed
✅ **Trivy scan passes:** No critical/high vulnerabilities (or documented)
✅ **Image pushed:** Appears in DockerHub (for master branch builds)
✅ **SARIF uploaded:** Security tab shows scan results

## What I've Verified

- ✅ All Dockerfiles have valid syntax
- ✅ All FROM statements present
- ✅ No obvious syntax errors (missing &&, etc.)
- ✅ Path-based triggers configured correctly
- ✅ Security scanning configured
- ✅ All version numbers are current

## What Still Needs Testing

- ⚠️ Actual Docker builds (requires Docker daemon)
- ⚠️ SHA256 checksums match
- ⚠️ All dependencies available
- ⚠️ Build caching works correctly
- ⚠️ Image size is reasonable

## Next Steps

1. **Test 1-2 simple containers first** (alfa, kustomize)
2. **Verify they build successfully**
3. **Test complex containers** (diagnostics, network)
4. **Build UBI images in order**
5. **Review security scan results**
6. **Merge to master when satisfied**
