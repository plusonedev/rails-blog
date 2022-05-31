# README

Testing out rails modularity with engines and managing their version by git submodules.

## Creating a new product

Follow the standard Rails new project command
`rails new blog`

## Add Submodules

```
$ git submodule add https://github.com/plusonedev/engine-posts.git lib/engines/posts
```

## Commit changes to add submodules to remote

```
  $ git commit -m "Added the submodule to the project."
  $ git push
```

# Update Engines

```
$ git submodule update --init --recursive

cd engines/[submodule]
git checkout [version_branch]
cd ..
git add [submodule]
git commit -m "updated [submodule] to [version]"
git push
```
