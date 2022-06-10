FILENAME="java-repos.txt"

while read -r repo
do
    git clone https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/DwijeshMishra/$repo.git
    cd $repo
    git remote set-url origin https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/DwijeshMishra/$repo.git
    git checkout -b feature
    cd ..
    cp project-specific.yaml $repo/  && cp .repo-config  $repo/
    cd $repo
    git add . 
    git config user.name "$(git --no-pager log --format=format:'%an' -n 1)"
    git config user.email "$(git --no-pager log --format=format:'%ae' -n 1)"
    git commit -am"update workflow"
    git push --set-upstream origin feature "https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/DwijeshMishra/$repo.git"
    cat .git/config
done < java-repos.txt
