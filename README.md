[![Latest Release Tag](https://badgen.net/github/tag/fusionauth/fusionauth-ios-sdk)](https://github.com/FusionAuth/fusionauth-ios-sdk/tags)
[![Dependabot](https://badgen.net/github/dependabot/fusionauth/fusionauth-ios-sdk)](https://github.com/FusionAuth/fusionauth-ios-sdk/network/updates)
[![Open PRs](https://badgen.net/github/open-prs/fusionauth/fusionauth-ios-sdk)](https://github.com/FusionAuth/fusionauth-ios-sdk/pulls)


An SDK for using FusionAuth in iOS Apps.

# Table of Contents

- [Overview](#overview)

- [Getting Started](#getting-started)

- [Usage](#usage)

- [Example App](#example-app)

- [Quickstart](#quickstart)

- [Documentation](#documentation)

- [Upgrade Policy](#upgrade-policy)

<!--
this and following tags, and the corresponding end tag, are used to delineate what is pulled into the FusionAuth docs site (the client libraries pages). Don't remove unless you also change the docs site.

Please also use ``` instead of indenting for code blocks. The backticks are translated correctly to adoc format.
-->

## Overview
<!--
tag::forDocSiteOverview[]
-->
This SDK allows you to use OAuth 2.0 and OpenId Connect functionality in an iOS app with FusionAuth as the
authorization server. It also provides a Token Manager to store, refresh, and retrieve tokens.

It's a highly standardized and simplified starting point for developers to easily integrate FusionAuth into their own custom mobile apps by taking care of all the dependencies.

Following OAuth 2.0 and OpenID Connect functionality are covered:
- OAuth 2.0 Authorization Code Grant
- OAuth 2.0 Refresh Token Grant
- OpenID Connect UserInfo
- OpenID Connect End Session

[AppAuth-iOS](https://github.com/openid/AppAuth-iOS) is used for the OAuth 2.0 Authorization Code Grant flow and OpenID Connect functionality.

The SDK is written in Swift and compatible with Object-C.
<!--
end::forDocSiteOverview[]
-->

## Getting Started

<!--
tag::forDocSiteGettingStarted[]
-->
To use the FusionAuth iOS SDK, add the following dependency 

TBD
<!--
end::forDocSiteGettingStarted[]
-->

## Usage

<!--
tag::forDocSiteUsage[]
-->
TBD
<!--
end::forDocSiteUsage[]
-->

## Example App

<!--
tag::forDocSiteExampleApp[]
-->
See the [FusionAuth iOS SDK Example](https://github.com/FusionAuth/fusionauth-quickstart-swift-ios-fusionauth-sdk) for a functional example of an iOS client that uses the SDK.
<!--
end::forDocSiteExampleApp[]
-->

## Quickstart

<!--
tag::forDocSiteQuickstart[]
-->
See the [FusionAuth iOS Quickstart](https://fusionauth.io/docs/quickstarts/quickstart-ios-swift-native-fusionauth-sdk/) for a full tutorial on using FusionAuth and iOS.
<!--
end::forDocSiteQuickstart[]
-->

## Documentation

<!--
tag::forDocSiteDocumentation[]
-->
See the latest [Full library documentation](https://github.com/FusionAuth/fusionauth-ios-sdk/blob/main/Documentation/Reference/README.md) for the complete documentation of the SDK.
<!--
end::forDocSiteDocumentation[]
-->

## Contributing
<!--
tag::forDocSiteContributing[]
-->
We hope you love using FusionAuth iOS SDK, but in case you encounter a bug or an issue with the SDK, please do let us know.

Please only report issues for the FusionAuth iOS SDK itself if you have an issue with documentation or a client library follow [these instructions.](https://github.com/FusionAuth/fusionauth-issues)

### Community Guidelines

As part of the FusionAuth community, please abide by [the Code of Conduct](https://fusionauth.io/community/forum/topic/1000/code-of-conduct).

### Reporting an Issue

Before reporting an issue, please search through the already open issues to see if you could contribute.

To report an issue, please follow the instructions of the bug, feature and general issue templates.

### Contributing Features and Fixes

Before starting with contributing, you'll want to look at and choose an issue to work on. Here is a basic workflow you want to work from:

1. Search the issue tracker for an issue that you want to work on. If your issue does not exist, please create a new one.
2. Search GitHub for an open or closed Pull Request that relates to the issue you want to work on. You may find that someone else is already working on it, or that the issue is already resolved in a different branch.

You can find all the open issues [here](https://github.com/FusionAuth/fusionauth-ios-sdk/issues).

Once you have found an issue you want to work on, we suggest to:

1. Fork the repository to your personal account.
2. Create a new branch with the name fix/issue-id or feat/issue-id.
3. And start working on that branch on the issue.

### Development Tooling

During development of new features and fixes, we suggest using the following code quality tools which are preconfigured for this project:
* TBD

### Submitting a Pull Request

When you are ready to submit your pull request, visit the main repository on GitHub and click the "Compare & pull request" button. Here you can select the branch you have been working on and create a pull request.

If you're creating a pull request for an issue, please include `Closes #XXX` in the message body where `#XXX` is the issue you're fixing. For example, `Closes #42` would close issue #42.

After you have submitted your pull request, several checks will be run to ensure the changes meet the project's guidelines. If they do, the pull request will be reviewed by a maintainer and subsequently merged.
<!--
end::forDocSiteContributing[]
-->

## Upgrade Policy

This library may periodically receive updates with bug fixes, security patches, tests, code samples, or documentation changes.

These releases may also update dependencies, language engines, and operating systems, as we\'ll follow the deprecation and sunsetting policies of the underlying technologies that the libraries use.

This means that after a dependency (e.g. language, framework, or operating system) is deprecated by its maintainer, this library will also be deprecated by us, and may eventually be updated to use a newer version.
