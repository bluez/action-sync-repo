# action-sync-repo
A GitHub Action for synchronizing the current repository with remote non-github repo

## Inputs
### `src_repo`
**Required** Complete URL of non-github repository to pull

### `src_branch`
**Optional** Name of branch to pull. Default `"master"`

### `dest_repo`
**Required** Name of github repo to sync

### `dest_branch`
**Optional** Name of branch to sync. Default `"master"`

### `github_token`
**Required** Github secret of destination repo.

## Example workflow
```
name: Sync repo

on:
  schedule:
    - cron: "*/6 * * * *"

jobs:
  sync:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Sync repository
      uses: tedd-an/action-sync-repo-test@master
      with:
        src_repo: 'https://git.kernel.org/pub/scm/bluetooth/bluez.git'
        src_branch: 'master'
        dest_repo: tedd-an/bluez-test
        dest_branch: 'master'
        github_token: ${{ secrets.ACTION_TOKEN }}

```
