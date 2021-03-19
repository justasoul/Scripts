# GIT
   
 ## Actualizar o actual feature branch com a versão de master
   * [LINK] (https://gist.github.com/santisbon/a1a60db1fb8eecd1beeacd986ae5d3ca)

## Revert a local change to a file (not yet commited)
````
git checkout -- <filename>
````
## Change all commit comments on a branch
  * CHECK: [LINK](https://stackoverflow.com/questions/14381044/how-do-i-change-a-git-commit-message-in-bitbucket/49482409)
````
It's basically 4 step process. But a bit risky if multiple team member are working on the same branch and have their own copies. (If you are the only one working on it, go for it)

This git manual explains it beautifully: Amending older or multiple commit messages

git rebase -i HEAD~X (X=No of commit messages you want to change)

Above command will open git file in editor. There replace text 'pick' with 'reword' and save the file.

It will open editor for every commit one by one, there you again change the commit message.

At the end: git push -f

````

## Add a new project as a repo
  * https://gist.github.com/alexpchin/102854243cd066f8b88e

## Revert a commit and split it into 2 distinct ones (to have more focused commits)
  * ````
    This will set us back one commit:
         git reset HEAD~1
         
    and our changes will be kept as unstaged
    then do
         git add -p
         
    and add anything that relates to the first focused issue (https://stackoverflow.com/questions/10605405/what-does-each-of-the-y-n-q-a-d-k-j-j-g-e-stand-for-in-context-of-git-p)
    
    afterwards just to a simple commit
         git commit -m "blabla first issue"
    
    Then add what remains as another commit:
         git add changed_file
         git commit -m "bleble second issue"
         
    last step would be to force push to remote
         git push -f
    
    ````

## Avoiding Foxtrot
  * [how to avoid foxtrot merge in git [duplicate]](https://stackoverflow.com/questions/55155810/how-to-avoid-foxtrot-merge-in-git)
````
I'm going to close this as a duplicate, but the "duplicate" question itself just defines foxtrot merges without explaining why they happen.

They happen because git pull means git fetch && git merge and that second git merge is a "foxtrot merge". It treats your work as the main branch, and someone else's work, done on master after you started on your work, as a secondary, probably-not-master branch. The goal of the hook is to prevent people from working on master and using git pull like this.

To avoid having this sort of thing happen, you can use this simple rule (perhaps a bit too simple but it works): never do any work on master yourself.

That is, after:

git clone <url>
cd <clone>
you begin work with:

git checkout -b feature/tall
to work on the new feature named tall. You, Alice—well, that's probably not your actual name, but I have three people doing things in this example, so I've assigned you the name "A"–do all your work on your own feature/tall, while Bob and Carol do all their work on their own feature branches, whatever their features' names are.

Then when your stuff is ready you do:

git checkout master && git fetch && git merge
or, if you like git pull (I don't):

git checkout master && git pull
You're now ready to merge your feature:

git merge feature/tall
and when the merge is complete—after resolving any merge conflicts if necessary—you can push again:

git push
and your work appears as a non-"foxtrot merge". Once your work is successfully merged and pushed you can delete your feature-branch. Meanwhile Bob and Carol can keep working on their features, or, if they finished before you did, your merge merges atop their merges.
````

## Working with remotes
  * [LINK](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)

## Git Cheatsheet
  * [atlassian-git-cheatsheet](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet)

## Git Feature Branch workflow
  * https://medium.com/@s.kang919/my-git-feature-branch-workflow-a4b9647ea459
  * https://gist.github.com/mindplace/b4b094157d7a3be6afd2c96370d39fad
  * https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
  * https://nvie.com/posts/a-successful-git-branching-model/

## Other
  * https://livablesoftware.com/tools-to-visualize-the-history-of-a-git-repository/
