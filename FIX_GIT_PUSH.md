# 🔧 Fix Git Push Authentication Error

## Problem
```
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

## Quick Solution: Use HTTPS Instead of SSH

### Step 1: Remove the SSH remote
```bash
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"
git remote remove origin
```

### Step 2: Add HTTPS remote instead
```bash
git remote add origin https://github.com/Caliber875/demo-cmms-backend-v1.git
```

### Step 3: Push to GitHub
```bash
git push -u origin main
```

When prompted, enter:
- **Username**: Your GitHub username (Caliber875)
- **Password**: Your GitHub Personal Access Token (NOT your GitHub password!)

### How to Get GitHub Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Name it: "Railway Deploy"
4. Select scopes: Check **"repo"** (full control of private repositories)
5. Click **"Generate token"**
6. **COPY THE TOKEN** - you won't see it again!
7. Use this token as your password when pushing

---

## Alternative: Fix SSH Keys (More Complex)

If you prefer SSH instead of HTTPS:

### Step 1: Generate SSH Key for New Account
```bash
ssh-keygen -t ed25519 -C "your-email@example.com" -f ~/.ssh/id_ed25519_caliber875
```

### Step 2: Add SSH Key to ssh-agent
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_caliber875
```

### Step 3: Copy SSH Public Key
```bash
cat ~/.ssh/id_ed25519_caliber875.pub
```

### Step 4: Add to GitHub
1. Go to: https://github.com/settings/keys
2. Click **"New SSH key"**
3. Title: "Railway Deploy Key"
4. Paste the public key
5. Click **"Add SSH key"**

### Step 5: Configure SSH Config
```bash
cat >> ~/.ssh/config << 'EOF'

# GitHub - Caliber875 account
Host github.com-caliber875
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_caliber875
    IdentitiesOnly yes
EOF
```

### Step 6: Update Git Remote
```bash
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"
git remote remove origin
git remote add origin git@github.com-caliber875:Caliber875/demo-cmms-backend-v1.git
git push -u origin main
```

---

## Recommended: Use HTTPS (Faster!)

HTTPS is simpler and faster for Railway deployment. Just use a Personal Access Token.

### Quick Commands:
```bash
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"
git remote remove origin
git remote add origin https://github.com/Caliber875/demo-cmms-backend-v1.git
git push -u origin main
```

Then enter your GitHub username and Personal Access Token when prompted.

---

## After Pushing Successfully

Once your code is on GitHub:

1. ✅ Go to https://railway.app/new
2. ✅ Click "Deploy from GitHub repo"
3. ✅ Select "Caliber875/demo-cmms-backend-v1"
4. ✅ Add environment variables
5. ✅ Generate domain
6. ✅ Deploy! 🚀

