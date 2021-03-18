# container-litecoin

A simple container to demonstrate running `litecoind`.

*Note*: Runtime configuration of `litecoind` is considered out-of-scope for this test.

## Container Image Scanning

Passes with `grype`:

```
$ grype flaccid/litecoin:0.18.1
 ✔ Vulnerability DB     [updated]
 ✔ Loaded image         
 ✔ Parsed image         
 ✔ Cataloged image      [17 packages]
 ✔ Scanned image        [0 vulnerabilities]

No vulnerabilities found
```
