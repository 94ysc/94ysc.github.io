copy CNAME  public/CNAME 
git add -A
git commit -m ''
git push

cd public

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:94ysc/94ysc.github.io.git  master
