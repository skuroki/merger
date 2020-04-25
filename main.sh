rm -rf work
git clone https://$TOKEN:x-oauth-basic@github.com/$USER/$REPOSITORY.git work
cd work
git config user.email $EMAIL
git config user.name $USER
git remote add upstream https://$TOKEN:x-oauth-basic@github.com/$UPSTREAM_USER/$REPOSITORY.git
git fetch upstream
git merge -m "Merge upstream" upstream/master
git push origin master
cd -
