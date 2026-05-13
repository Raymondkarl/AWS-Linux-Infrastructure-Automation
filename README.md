# Initialize Git repository
git init

# Check current files
git status

# Add all files
git add .

# Commit files
git commit -m "Initial Terraform infrastructure setup"

# Rename branch to main
git branch -M main

# Add GitHub remote repository
git remote add origin https://github.com/Raymondkarl/AWS-Linux-Infrastructure-Automation.git

# Verify remote
git remote -v

# Push to GitHub
git push -u origin main
