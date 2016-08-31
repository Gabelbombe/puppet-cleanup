#!/usr/bin/env -e
for branch in $(git branch | sed 's/..//') ; do
  echo -e "git checkout ${branch}"
  git checkout $branch

  # undetermined func: git-hash
  # replaced with rev-parse ??
  echo -e "Old HEAD: $(git rev-parse --verify HEAD)"

  for new_root in "${@:-HEAD}" ; do
    new_root_hash=$(git log -n1 --format=%H "$new_root")
    echo -e "$new_root_hash"
  done > .git/info/grafts
  git filter-branch --force
  echo "New HEAD: $(git rev-parse --verify HEAD)"
done
rm .git/info/grafts


## REF: https://github.com/alexherbo2/dotfiles/blob/master/bin/git-gc-all-ferocious
confirm git-gc-all-ferocious $AGGRESSIVE # --aggressive
