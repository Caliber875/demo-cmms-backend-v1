# 📸 Vercel Settings - What to Change (Visual Guide)

## 🎯 The Problem in Your Screenshot

Based on your Vercel environment variables screenshot, I can see you have:
- ✅ `FRONTEND_URL` set correctly
- ✅ `JWT_SECRET` set correctly
- ✅ `MONGODB_URI` set correctly
- ✅ `NODE_ENV` set to production

**BUT** the build is still failing because of the **Build Command** setting!

---

## 🔧 What You Need to Change

### Step-by-Step Visual Guide

1. **Go to Your Vercel Project**
   ```
   https://vercel.com/dashboard
   → Click on "demo-cmms-backend" project
   ```

2. **Navigate to Settings**
   ```
   Top menu: Code → Issues → Pull requests → Actions → Settings
   Click "Settings" (gear icon)
   ```

3. **Find "Build & Development Settings"**
   ```
   Settings page → Scroll down
   Look for section called "Build & Development Settings"
   ```

4. **Current (WRONG) Settings** ❌
   ```
   Build & Development Settings
   ────────────────────────────
   Framework Preset: Other
   
   Build Command:     [Override]  npm run dev  ← WRONG!
   Output Directory:  [Override]  (empty)
   Install Command:   [Override]  npm install  ← This is OK
   Development:       [Override]  npm run dev  ← Not used anyway
   ```

5. **New (CORRECT) Settings** ✅
   ```
   Build & Development Settings
   ────────────────────────────
   Framework Preset: Other
   
   Build Command:     [Override]  npm run build  ← CHANGE THIS!
   Output Directory:  [Override]  dist           ← ADD THIS!
   Install Command:   [Override]  npm install    ← Keep this
   Development:       [Override]  npm run dev    ← Keep this
   ```

---

## 📝 Exact Steps to Fix

### 1. Go to Build & Development Settings

In your Vercel project:
```
Settings → General → Build & Development Settings
```

### 2. Click Override on Each Setting

You'll see buttons that say "OVERRIDE" next to each setting. Click them.

### 3. Enter These Exact Values

#### Root Directory
```
Leave empty (or just "." if it asks)
```

#### Framework Preset
```
Select: Other
```

#### Build Command
Click "OVERRIDE" and enter:
```bash
npm run build
```

#### Output Directory
Click "OVERRIDE" and enter:
```
dist
```

#### Install Command
Click "OVERRIDE" and enter:
```bash
npm install
```

#### Development Command
Click "OVERRIDE" and enter (not used in production, but set anyway):
```bash
npm run dev
```

### 4. Click "Save"

Scroll to bottom and click **Save** button.

---

## 🔐 Verify Environment Variables

Go to: **Settings → Environment Variables**

Make sure EACH variable is checked for ALL three environments:

```
┌─────────────────┬─────────────────────────────┬─────────────────────────┐
│ Key             │ Value                       │ Environments            │
├─────────────────┼─────────────────────────────┼─────────────────────────┤
│ MONGODB_URI     │ mongodb+srv://karthick...   │ ☑ Production            │
│                 │                             │ ☑ Preview               │
│                 │                             │ ☑ Development           │
├─────────────────┼─────────────────────────────┼─────────────────────────┤
│ JWT_SECRET      │ TBBpEF7dvljMy4FZcsYsB9wj... │ ☑ Production            │
│                 │                             │ ☑ Preview               │
│                 │                             │ ☑ Development           │
├─────────────────┼─────────────────────────────┼─────────────────────────┤
│ NODE_ENV        │ production                  │ ☑ Production            │
│                 │                             │ ☐ Preview (not needed)  │
│                 │                             │ ☐ Development           │
├─────────────────┼─────────────────────────────┼─────────────────────────┤
│ FRONTEND_URL    │ https://demo-cmms-eight...  │ ☑ Production            │
│                 │                             │ ☑ Preview               │
│                 │                             │ ☑ Development           │
└─────────────────┴─────────────────────────────┴─────────────────────────┘
```

**Important**: Click the checkboxes for each environment!

---

## 🚀 Deploy the Fix

### Option 1: Git Push (After committing new files)

```bash
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"

# Add the new config files I created
git add vercel.json .vercelignore

# Commit
git commit -m "fix: Add Vercel configuration for proper deployment"

# Push to trigger deployment
git push origin main
```

Vercel will automatically detect the push and start a new deployment.

### Option 2: Manual Redeploy

If you've already updated settings but deployment hasn't triggered:

1. Go to **Deployments** tab in Vercel
2. Find the failed deployment
3. Click the **three dots** (...) on the right
4. Click **"Redeploy"**
5. Wait 2-3 minutes

---

## ✅ How to Know It's Working

### 1. Check Build Logs

In Vercel deployment logs, you should see:

```
Running "vercel build"
Vercel CLI 48.10.5
Running "install" command: `npm install`...
✓ Installed dependencies
Running "build" command: `npm run build`...
> cmms-server@1.0.0 build
> tsc
Build completed successfully
✓ Build successful
```

**NOT** this (which is what you're seeing now):
```
Running "install" command: `npm run dev`...  ← WRONG!
sh: line 1: nodemon: command not found
Error: Command "npm run dev" exited with 127
```

### 2. Check Deployment Status

- ❌ Old: "Failed to build" (red X)
- ✅ New: "Ready" (green checkmark)

### 3. Test Your Backend

Once deployed, visit:
```
https://your-vercel-app.vercel.app/health
```

You should see:
```json
{
  "status": "healthy",
  "timestamp": "2025-11-25T12:34:56.789Z",
  "uptime": 12.345,
  "memory": {
    "used": 45.67,
    "total": 512
  }
}
```

---

## 🎨 Before vs After

### ❌ BEFORE (What you have now)
```
Build Command: npm run dev
Output Directory: (empty)

Result: ❌ Build fails with "nodemon: command not found"
```

### ✅ AFTER (What you need)
```
Build Command: npm run build
Output Directory: dist

Result: ✅ Build succeeds, TypeScript compiles to JavaScript
```

---

## 📊 Visual Flowchart

```
Current Flow (WRONG):
┌──────────────┐
│ Vercel Start │
└──────┬───────┘
       │
       ▼
┌──────────────────┐
│ Run: npm run dev │ ← Tries to run development mode
└──────┬───────────┘
       │
       ▼
┌─────────────────────┐
│ Run: nodemon        │ ← nodemon not installed
└──────┬──────────────┘
       │
       ▼
┌──────────────┐
│ ❌ ERROR 127 │ ← Command not found
└──────────────┘

New Flow (CORRECT):
┌──────────────┐
│ Vercel Start │
└──────┬───────┘
       │
       ▼
┌────────────────────┐
│ Run: npm install   │ ← Install dependencies
└──────┬─────────────┘
       │
       ▼
┌────────────────────┐
│ Run: npm run build │ ← Compile TypeScript
└──────┬─────────────┘
       │
       ▼
┌────────────────────┐
│ Run: tsc           │ ← TypeScript compiler
└──────┬─────────────┘
       │
       ▼
┌────────────────────┐
│ Output: dist/      │ ← JavaScript files created
└──────┬─────────────┘
       │
       ▼
┌────────────────────┐
│ ✅ BUILD SUCCESS   │
└────────────────────┘
```

---

## 🆘 Still Not Working?

### Error: "Build Command is already set"
- **Solution**: Click the "OVERRIDE" button to enable editing

### Error: "Changes not saving"
- **Solution**: Scroll down and click the "Save" button at the bottom

### Error: "Deployment not triggering"
- **Solution**: Go to Deployments → ... → Redeploy

### Error: "Still showing npm run dev in logs"
- **Solution**: 
  1. Clear browser cache
  2. Hard refresh (Cmd+Shift+R on Mac, Ctrl+Shift+R on Windows)
  3. Check if settings actually saved

### Error: "dist folder not found"
- **Solution**: Make sure:
  1. Build Command is `npm run build`
  2. Output Directory is `dist`
  3. vercel.json file is committed to git

---

## 📋 Checklist

Before redeploying, make sure you've done ALL of these:

- [ ] Changed Build Command to `npm run build`
- [ ] Set Output Directory to `dist`
- [ ] Committed `vercel.json` file
- [ ] Committed `.vercelignore` file
- [ ] Pushed changes to GitHub
- [ ] Verified environment variables are set
- [ ] Clicked "Save" in Vercel settings
- [ ] Triggered new deployment

---

## 🎯 Quick Command Reference

```bash
# Navigate to server directory
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"

# Check if new files exist
ls -la | grep vercel

# Should show:
# .vercelignore
# vercel.json

# Add and commit
git add vercel.json .vercelignore
git commit -m "fix: Add Vercel deployment configuration"
git push origin main

# Test build locally
npm run build
npm start

# If successful, check:
curl http://localhost:5001/health
```

---

## 🎉 Success Indicators

You'll know it's working when you see:

1. ✅ Build logs show `npm run build` (not `npm run dev`)
2. ✅ TypeScript compilation succeeds
3. ✅ Deployment status shows "Ready" with green checkmark
4. ✅ Visiting `/health` endpoint returns JSON response
5. ✅ No "command not found" errors in logs

---

**That's it!** Follow these exact steps and your deployment will succeed! 🚀

