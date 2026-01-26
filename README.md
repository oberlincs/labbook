# labbook

This repository exists to build one, consistent, version of the `mdbook` tools
that we can depend on.

## Checking out this repository

This uses Git submodules (I'm sorry). You'll need to checkout the submodules
too.

## Updating the version of the tool

cd into the corresponding tool directory and check out the appropriate release
tag and then commit it.

```shell
cd mdBook
git checkout v0.4.52
cd ..
git add mdBook
git commit -m 'Update mdBook to v0.4.52'
git push
```

## Building a new release

TODO


## Rationale

Some other time...
