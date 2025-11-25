# ⚡ Quick Start - Backend Deployment

## 🚨 Your Error
```
Error: Command "npm run dev" exited with 127
nodemon: command not found
```

## ✅ Quick Fix (Choose One)

### 🎯 Option A: Railway (5 minutes, Recommended)

1. Go to: **https://railway.app/new**
2. Click **"Deploy from GitHub repo"**
3. Select: **`Karthick1242004/demo-cmms-backend`**
4. Add these variables:
   ```
   MONGODB_URI=mongodb+srv://karthick1242004:9894783774@karthick124.8ruyxjc.mongodb.net/construction
   JWT_SECRET=TBBpEF7dvljMy4FZcsYsB9wj4fhwJ9r55EsnURlLY9BECFspDKIysalPDnLDT46v
   NODE_ENV=production
   FRONTEND_URL=https://demo-cmms-eight.vercel.app
   ```
5. Settings → Networking → **Generate Domain**
6. Copy URL and update frontend env
7. ✅ **Done!**

**Test**: Visit `https://your-app.railway.app/health`

---

### 🔧 Option B: Fix Vercel (10 minutes, Has Limitations)

#### Step 1: Commit Files
```bash
cd "/Users/karthicks/Desktop/cmms copy/construction-dashboard-frontend/server"
git add vercel.json .vercelignore
git commit -m "Fix: Add Vercel configuration"
git push origin main
```

#### Step 2: Update Vercel Settings
Go to: **Vercel Dashboard → Your Project → Settings**

Change these:
- **Build Command**: `npm run build` (was: `npm run dev`)
- **Output Directory**: `dist`
- **Install Command**: `npm install`

#### Step 3: Redeploy
Deployments tab → ... → Redeploy

⚠️ **Note**: You'll still have 10s timeout and no WebSocket support

---

## 📊 Quick Comparison

| Feature | Railway | Vercel |
|---------|---------|--------|
| Setup Time | ✅ 5 min | ⚠️ 10 min |
| Timeout | ✅ None | ❌ 10s |
| WebSockets | ✅ Yes | ❌ No |
| Chat Feature | ✅ Works | ❌ Won't work |
| Cost | ~$5/month | Free (limited) |

## 🎯 Recommended
✅ Backend: **Railway**  
✅ Frontend: **Vercel** (keep current)  
✅ Database: **MongoDB Atlas** (keep current)

---

## 📚 Detailed Guides

Need more info? Check these files:

- `DEPLOYMENT_ISSUE_SOLUTION.md` - Full analysis & solutions
- `VERCEL_FIX_GUIDE.md` - Detailed Vercel instructions
- `VERCEL_SETTINGS_GUIDE.md` - Visual guide with screenshots
- `VERCEL_VS_RAILWAY.md` - Platform comparison
- `deploy-railway.sh` - Automated deployment script

---

## 🆘 Still Stuck?

### Test locally first:
```bash
npm run build
npm start
curl http://localhost:5001/health
```

### Check logs:
- Vercel: Dashboard → Deployments → View logs
- Railway: Dashboard → Your service → View logs

### Common issues:
- ❌ "nodemon not found" → Change build command to `npm run build`
- ❌ "dist not found" → Set output directory to `dist`
- ❌ "MONGODB_URI undefined" → Check environment variables
- ❌ "Timeout error" → Switch to Railway

---

**Choose Railway for best results!** 🚀

