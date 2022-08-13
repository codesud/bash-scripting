# Shell Scripting

### What is PAT ???
```
Personal Access Token, this is the GitHub Recommended way of authentication.
```

### How to generate the PAT ?

```
Open your GitHub ---> Top Right Corner --> Settings ---> Left Pane Botton, click Developer Settings ---> Click PAT ---> Chose all the access options, copy the PAT and save it
```

### How to authenticate to github, using the PAT ( Password Authentication Token )

1) Git clone the repo
2) open the VS-CODE and that folder in VC Code
3) Now open the terminal ( Head Pane )
4) In the terminal CLI, type the following commands 
```
 git add . 
 git commit -m "Add a meaningful line"
 git push  ( This will fail and try to run the same command one more time)
 git push  ( Now it will ask you for the token, enter the token generated in the above step)
```

Now you're authenticated and should be able to push your code without any limitations

________________________________________________________________________________________________________________________

### ***** This is optional or CLI way of authentication *****

You can also authenticate using commands as well. But you need to repeate the process for all the repo's you create in future as well
```
git remote set-url origin https://PAT@github.com/USER-NAME/repoName.git
```

Now you're authenticated.

REF: https://stackoverflow.com/questions/66231282/how-to-add-a-github-personal-access-token-to-visual-studio-code