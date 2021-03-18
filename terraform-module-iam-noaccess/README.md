# terraform-module-iam-noaccess

A simple terraform module that takes a list of users to create with explicitly no access.

*Note*: this is intended to be almost the simplest module possible for the test requirements.
It does not make use of a lot of contextual and re-usable techniques, best practices etc.

## Example usage
```
module "no-access-sorry" {
  source    = "../"
  usernames = ["cardi_b", "justin_bieber"]
}
```
