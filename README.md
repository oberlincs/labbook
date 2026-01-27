# labbook

This repository exists to build one, consistent, version of the `mdbook` tools
that we can depend on.

## Checking out this repository

This uses Git submodules (I'm sorry). You'll need to checkout the submodules
too. To check them out, run the following command.

```shell
./submodule-version.sh init
```

## Updating the version of the tools

Change the version in the `VERSIONS` file. These should be git tags for the corresponding project.

Run `./submodule-version.sh update` to update them. Add the changed submodules
(and `VERSIONS`) using `git add` and then commit and push as normal. Something
like this.

```shell
# edit VERSIONS and set MDBOOK=v0.5.0
./submodule-version.sh update
git add VERSIONS mdBook
git commit -m 'Update mdBook to v0.5.0'
git push
```

## Building a new release

After updating the tools and pushing, creating a new release requires pushing a new tag.

```shell
git tag v1.0.0
git push --tags
```


## Rationale

Some other time...
