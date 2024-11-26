# Security Policy

For Responsible Disclosure Program, Discovering Security Vulnerabilities
 and Reporting a Vulnerability please follow https://fusionauth.io/security

## Supported Versions

| SDK Version | Tested FusionAuth | Tested Simulator | Tested xcode  | Tested swift   | Supported          |
|-------------|-------------------|------------------|---------------|----------------|--------------------|
| \>= 0.1.0   | 1.47 - 1.54       | iOS 15.5 - 18.1  | 14.3.1 - 15.4 | 5.8.1 - 5.10.1 | :white_check_mark: |

## Versioning Guidelines

We use [Semantic Versioning 2.0.0](https://semver.org/) with the following release examples:

### Major

When the Authorization / Token Manager API is changed in a non-backwards compatible way.

### Minor

When the Authorization / Token Manager API is extended with new functionality in a backwards compatible way.

### Patch

When the Authorization / Token Manager API is not changed, but an internal bug is fixed.

### FusionAuth Server Compatibility

The Mobile SDK version may be tied to the FusionAuth Server version. This is to ensure that the Mobile SDK is compatible with the FusionAuth Server. 

If the resulting SDK release stays compatible with the new and earlier Fusionauth Server version, the SDK is published as a Minor release. 

If the resulting SDK release is only compatible with the new FusionAuth Server version. It is considered a non-backwards compatible change, and the SDK is released in a Major release.
