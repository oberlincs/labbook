# labbook

This repository exists to build one, consistent, version of the `mdbook` tools
that we can depend on for building our lab websites.

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

The `mdbook` version 0.4 architecture is not very good. Each preprocessor
depends on a specific version of `mdbook` and, in the case of `mdbook-katex`,
depends on some fork of `mdbook`! Fortunately, other than some warnings at
runtime, the preprocessors built for some version of 0.4 all seem to work
together.

The problems arise when trying to build the lab sites (or really any `mdbook`)
locally versus in CI. The solution is to just use pre-built binaries with the
appropriate versions all the time. Unfortunately, `mdbook` and the
preprocessors we use don't all have binary builds for each of the three
architectures I care about:
- x86_64-unknown-linux-gnu (for CI builds)
- aarch64-apple-darwin (for modern Macs)
- x86_64-apple-darwin (for older Macs)

This repository serves to alleviate this issue by packaging up the four
binaries, `mdbook`, `mdbook-admonish`, `mdbook-katex`, and `mdbook-tera` for
each of the three architectures.

Individual lab sites can, as part of their build scripts, download (and cache)
the binaries for the appropriate architecture and then run them. See the
(private to this organization) `csci210-labs` repo's `ci/build.sh` for an
example of how to do this.

Version 0.5 fixes the architectural problems to some extent by
separating out the `mdbook` crates into multiple crates, including
`mdbook-preprocessor` which the preprocessors can depend on instead.

Unfortunately, version 0.5 is a breaking change and none of the three
preprocessors we use have been updated (except for `mdbook-katex` which
currently has an alpha release out).
