# Changelog

## [1.0.0-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v1.1.0...v1.0.0-rc) (2026-03-30)


### Features

* Add client_id as a logout option ([3fd8de7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3fd8de7038a76f12de775c1734b3c023be728be5))
* add, test and verify macos-15, xcode-16.1 and swift-6.0.2 compatibility ([#22](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/22)) ([de49b36](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/de49b362ec9cf0b6839536e283d4af96f275ee12))
* allow configuration by .plist file ([c7686da](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c7686da228b560fc8f4a7ae4c7216310426fcfce))
* **dependabot:** add initial configuration ([721bb08](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/721bb083b21ebe6dec9fa2ff8d96f34ca8ee1493))
* **e2e-test:** add fusionauth instance ([e588309](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/e58830907ebc4a43fab7c15d5d712c1b76f781b3))
* **e2e-test:** add fusionauth matrix test ([c842bc5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c842bc581e0ea969cd1654362e6ff24f291396c8))
* **e2e-test:** move checkout repository before fusionauth setup ([2682a8f](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/2682a8ff9f22522fee767c205ba6a0b97afb525f))
* initial fusionauth swift SDK for iOS with workspace and sample quickstart ([#6](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/6)) ([b544665](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b54466583c52ed54b09700445d19d8785319d541))
* **release:** use workflow_run instead of inherited job ([#36](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/36)) ([93f1f41](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93f1f41cc49890839a78b3c051f58c271918f739))


### Bug Fixes

* add debugging as a repository variable. ([ad32a98](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ad32a98d9bc3144f7db499936c7d30bddcaee458))
* added installation source ([#131](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/131)) ([dd4b561](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/dd4b561751d496c0dc0e6cdb469bc5fa1afa87f7))
* call initialize on app init ([f008646](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f008646547d18cadee58a0ed06dcb2d9246e53ee))
* debug the wrong version being used. ([df25e9d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/df25e9d50750525e21143e714abb9d9039ff1d7a))
* **deps:** bump github.com/openid/appauth-ios from 1.7.6 to 2.0.0 ([#71](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/71)) ([eb43ca5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/eb43ca5fd1306f5c76e975563ef0b68b6dd705de))
* **deps:** bump the prod-github-actions group with 2 updates ([#40](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/40)) ([cd9bfac](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/cd9bfac23b946a1735911bb9ed634f21a3ae8ce1))
* **e2e-test:** use main for fusionauth-docker-image-version ([bd4bf06](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/bd4bf06479d62fb010977f67ca793936df4d99c5))
* **e2e-test:** use main for fusionauth-docker-image-version ([9732d7a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9732d7af7b8b3744ebe5f91095fe0a14c504ec93))
* end to end tests are failing when starting a pre-release ([#116](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/116)) ([a073f35](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a073f352a00802ed197f424719abc59b85f3075f))
* error when targeting macOS / macCatalyst ([98f0e2e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/98f0e2e33189507c7a6fa02c347a3ed2abba210a))
* extra files should be updated in the workflow. ([852e0ee](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/852e0ee02ebc64d61fddb25a19ef1e4b3cf11750))
* fix error "UI API called on a background thread" when clicking "Log out" ([2214825](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/2214825af91d1560ba6f57afb9d7e9e67c841f8f))
* intermittent failures in the end to end tests ([#133](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/133)) ([1a2c904](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/1a2c904475e27e5343909a2c2eae386776bab674))
* **release:** add dependency to initial tests ([8ede5d5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8ede5d5d1043bf9a182a198113658453bdcc01c3))
* **release:** add PR label job as temporary fix for missing labels ([fb3c416](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/fb3c41614f4b377c9c0ff43283608b82c23de83e))
* **release:** only allow release flow to trigger when workflow_run.conclusion is successful ([b3e8b40](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b3e8b40d6d30d76025c5fecf5d06b6b3f38288a1))
* **release:** remove workflow_run and use workflow include instead ([46aafa3](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/46aafa388aa25cf6c188d572b0766a6051bc81f9))
* remove codeChallenge and codeChallengeMethod ([a0f233b](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a0f233b1781b6188285c433a8a54ee2c62f3f9cb)), closes [#25](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/25)
* set the current version. ([1095e39](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/1095e390d22f18f42a76c7e7a90f26227b7787b7))
* set the next version correctly. ([9bf270e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9bf270e4cd78f50d2653d1e0fc6fc06b82523366))
* use idToken from token manager ([4d11b85](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/4d11b851cfe7222d42ce0ee22c1da3a1c194cb9e))


### Code Refactoring

* add oauth static func ([af8f481](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/af8f4817deca0bbbe032c6e20cab2cc903dc055c))
* code cleanup ([1003c46](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/1003c460aa864dce992f50308cacfdcaca909945))
* **docs:** remove swift-docc-plugin ([913d73a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/913d73ab327d4643320afba4de440d7cd0e8a3a9))
* **e2e-test:** bump fusionauth to 1.54.0, add upload of xcresult ([7b7ced0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/7b7ced05fee53fe6866a6ca87a09f44a096f6534))
* **e2e-test:** refactor fusionauth matrix test ([2872c8f](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/2872c8fdf281905636b952212063fd33522e09dd))
* **fusionauth:** update config to 1.53.3 ([e209300](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/e20930045b41e78bf0d4e8ec6736d1bacb69fe80))
* **mobsf:** bump python version to 3.9 ([a4f778a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a4f778abc77ac971f0774a6fbd16c051d7798c33))
* move ObservableObject to example ([ba96771](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ba96771d8a68404a2b8acd91717a5d8052c5f184))
* **Quickstart:** add version switch for Preview macro below swift 5.9 ([da8bdf0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/da8bdf0422b7f7e60bbca6178ef9c37d63c6e7e0))
* **quickstart:** change repository reference ([4435790](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/443579013b3982eb35b21d65442998101e7567d0))
* **Quickstart:** downgrade objectVersion (Xcode Project Format) ([800f524](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/800f5249d9476e3a657cefc4485c89fb725269cf))
* **quickstart:** fix sdk path and update dependencies ([b42a415](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b42a415ff0e234cd9801a9c801b9a227b328ce55))
* **Quickstart:** remove preview from views, add icons, color ([4b2fd15](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/4b2fd1533415a0240318e0e23189384954dfa113))
* **QuickstartTests:** increase timeouts ([4d1b401](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/4d1b40126b0296c6c5534b4119aa1875af325941))
* remove debug message ([f90109a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f90109a1d38a89c13991d261a5986fd5850e8c3e))
* show Alert when error occurs while trying to login ([f443749](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f443749e35b4380e594270c500a1d0e0459dc1aa))
* use Logger instead of print ([#35](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/35)) ([5df10f7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5df10f75eed1074584a97caf877bc72e9a40c903))
* validate issuer (url) when retrieving configuration ([47898ca](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/47898ca1584e744a2cb96f04e17d6ba255bc81f0)), closes [#26](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/26)


### Miscellaneous Chores

* **main:** release 0.1.1 ([#32](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/32)) ([5a0c0a1](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5a0c0a137c4f8813096f955972da3f70249b5e25))
* **main:** release 0.1.1-rc ([#31](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/31)) ([92ce5db](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/92ce5db21dd5562fd8f0697b0f721378620aad70))
* **main:** release 0.2.0 ([#39](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/39)) ([6da2965](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/6da29654a4c12d95ceef1ae56c97ecbcaee83f64))
* **main:** release 0.2.0-rc ([#38](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/38)) ([f5204f2](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f5204f2abf7cc71a7e670c6b377740711ee76036))
* **main:** release 0.3.0 ([#45](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/45)) ([3c1b565](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3c1b56519671a1ad80dc7cd0d09d3c7d1eee6ee4))
* **main:** release 0.3.0-rc ([#41](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/41)) ([ada4b9b](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ada4b9b5bc362a6e5a9b01db98c54bdb59894177))
* **main:** release 0.3.0-rc.1 ([#44](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/44)) ([0880a83](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0880a83e8a1dcc036234e381246bbf7f88ba8de6))
* **main:** release 1.0.0 ([#119](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/119)) ([7608850](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/76088505b3dc56f503b25a009c79935d1fc62035))
* **main:** release 1.0.0-rc ([#117](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/117)) ([e1e4fd4](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/e1e4fd4af929b632c3cf154825642bdd1f3593ba))
* **main:** release 1.1.0 ([#129](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/129)) ([ade370c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ade370c468a91ca44281a1d6119ae6e8f66eef8c))
* **main:** release 1.1.0-rc ([#128](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/128)) ([8bc997a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8bc997ad5adc71c6c8669132abe3792cbfd9c102))
* release 1.0.0 ([79afefb](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/79afefb998fcdfb832150aa024fc68d8d6a6077a))
* release 1.0.0-rc ([185f45f](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/185f45f449b4b66a5023187e56c346d0ccded1be))
* release 1.0.0-rc ([d0c10a0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d0c10a0bfd00a9ad83c2fd7852e316f8412de2fd))
* **release:** 0.1.0 ([dfbaf18](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/dfbaf1861d54ce85e47ffb654eb88aa1bd795a5a))
* sync release manifests ([d540687](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d540687c63c25e438d44071516962ebd18e18e07))
* sync release manifests ([6c3c3a5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/6c3c3a5834808a5dc1e91ba8d86b8966063dbe16))
* sync release manifests ([56ee615](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/56ee615120aa085ab812d724f30352836fd474ac))


### Build System and Dependencies

* **deps:** bump actions/setup-python in the prod-github-actions group ([#16](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/16)) ([57c258a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/57c258a2233f309c98773d9579cb7989101cf4b7))
* **deps:** bump AppAuth pre swift 5.10 ([2269dcc](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/2269dcc2c977112e3c0170845ed8fed039e61397))
* **deps:** bump fusionauth to 1.55.1 ([ea923c7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ea923c791239387adcd59e075c4c773f73aa4516))
* **deps:** bump fusionauth/fusionauth-app ([#56](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/56)) ([6934ecf](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/6934ecfafabf0bd2b9a45620e801ac80f0b3edf3))
* **deps:** bump fusionauth/fusionauth-app ([#64](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/64)) ([486d799](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/486d799a10fb03e3544c32d310730127272c3f16))
* **deps:** bump fusionauth/fusionauth-app ([#74](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/74)) ([d2fc0b0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d2fc0b0782276b6caac2025066dd5c94ac4f448e))
* **deps:** bump github.com/realm/swiftlint ([8f2e98a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8f2e98aaf4db05dc94145dc5c696b26e973d8b6f))
* **deps:** bump github.com/realm/swiftlint ([aa658b9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/aa658b980778db03a8a83fb4f522562b05172dc9))
* **deps:** bump github.com/realm/swiftlint ([#29](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/29)) ([d8c02d2](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d8c02d22bd9ed5f2b159d42f553a1ab4e11b1f41))
* **deps:** bump github.com/realm/swiftlint ([#33](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/33)) ([5cce0b4](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5cce0b41d8fa5e2cb2ca3ead9eb1be2ace29cc0a))
* **deps:** bump github.com/realm/swiftlint ([#62](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/62)) ([0b89eea](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0b89eea7ec713be8310902d689929a0a8c9f6146))
* **deps:** bump github.com/realm/swiftlint ([#68](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/68)) ([d7dd34c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d7dd34c73068273d9b36efbcd3d945111dc8f90b))
* **deps:** bump github.com/realm/swiftlint from 0.59.1 to 0.60.0 in the gradle-minor-dependencies group ([59271ab](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/59271abeae80f880597ca128fa3352e6bcb504b0))
* **deps:** bump github.com/realm/swiftlint from 0.63.0 to 0.63.1 in the gradle-minor-dependencies group ([5b5c3a8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5b5c3a82db47b70ae2df7e9e5bd549a1ac9b531e))
* **deps:** bump github/codeql-action in the prod-github-actions group ([181b53a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/181b53a66b5b1baed87e3ff171b2c5dc381d0738))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#23](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/23)) ([094fa86](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/094fa86a568eb8bd3d6cae85752a035491ebeda5))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#24](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/24)) ([9c44c50](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9c44c50f2bde91cf015817e6aa14bf3950626890))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#4](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/4)) ([12b7d8d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/12b7d8d37fc49e5ca924963b1d02c7725c001da0))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#46](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/46)) ([93e59ae](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93e59ae379b62e38417501a1b23a94883255434e))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#7](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/7)) ([897d5c1](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/897d5c12d77c260f70ade71ce1b810dccb51862d))
* **deps:** bump multiple dependencies ([#69](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/69)) ([941483e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/941483ed7cab93cc3fcdfce5a4a6e3b37b85eb75))
* **deps:** bump opensearchproject/opensearch ([#47](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/47)) ([00848a7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/00848a74e7b7fc2c1b84f277c8269f1387095f13))
* **deps:** bump opensearchproject/opensearch ([#54](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/54)) ([0677dd8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0677dd8b55a34d66c379e099b1cbebfb2a3a76ee))
* **deps:** bump opensearchproject/opensearch ([#78](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/78)) ([c66166a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c66166a1af4d614a5a5440c06e13061bdf802181))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#49](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/49)) ([868793d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/868793df1cd004e21fbb57ce09b48c0c5fc4d957))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#50](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/50)) ([dd76580](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/dd765805e6d4c0374ceebeeb67d497fe20a1b2f0))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#80](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/80)) ([a1eb4e9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a1eb4e98b721d6cf78cf1803f0fb7cfcb097e101))
* **deps:** bump Quickstart dependencies ([05e5425](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/05e542557eb5b9800482bf8eb9fe14667179b485))
* **deps:** bump stanfordbdhg/action-swiftlint ([#34](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/34)) ([2731fa4](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/2731fa4f9ba42b1892c12ba6e385f0259f8bb9c0))
* **deps:** bump swift to 6.1.1 ([51a1900](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/51a1900e6491ffda76072b00f1af11616b1dbff3))
* **deps:** bump swift-actions/setup-swift ([#82](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/82)) ([3be89d7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3be89d703effa56899c2df2aa0c91b645cf301af))
* **deps:** bump swift, xcode, and simulator-version ([daac87a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/daac87a49c1c34ba6f89e762fab03a55bc1eb5d5))
* **deps:** bump swiftlint and cryptoswift ([c7aa8e3](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c7aa8e31e7877757747de1d22080df27a88e1b88))
* **deps:** bump the prod-github-actions group across 1 directory with 2 updates ([#15](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/15)) ([0686c1e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0686c1e643f5271dee6598736392249238b6a182))
* **deps:** bump the prod-github-actions group across 1 directory with 2 updates ([#20](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/20)) ([3e3e329](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3e3e329da5b5d10f345ebede2a6f37ee3bea61e5))
* **deps:** bump the prod-github-actions group across 1 directory with 3 updates ([#30](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/30)) ([01f6a16](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/01f6a160c15b847a02cee4c31eedb43bb0f74560))
* **deps:** bump the prod-github-actions group across 1 directory with 3 updates ([#55](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/55)) ([06f8627](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/06f862785bfde3a177ef3237abfda9529017d308))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([ba93df1](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ba93df13cc0711a6047f79bc677a7e9ca08250f2))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([930d5d6](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/930d5d646be5a55bc232fca564a1b68de3201c93))
* **deps:** bump the prod-github-actions group with 2 updates ([#27](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/27)) ([a4460c3](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a4460c316cd5b4027452c4dba1e2186779e88526))
* **deps:** bump the prod-github-actions group with 2 updates ([#42](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/42)) ([ec4d263](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ec4d2631529ff301e13af3cef20f5b8469f09341))
* **deps:** upgrade SwiftLint to 0.57.0 minimum ([b1c28bb](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b1c28bbc9d052a40fdf78b28c367258308bf0124))
* move SwiftLint to testTarget ([b19cf07](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b19cf07cb2a7c4338a304aa36c8a706ae03007dd))
* restore internal project structure for Sample ([af079bc](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/af079bc6588f9869a465f17dddfdea832fb4d64d))


### Docs

* add 0.1.1 release details ([87bacd6](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/87bacd63e0fa25a19937172f375a67389afb1a55))
* **CONTRIBUTING:** add further details ([00ca8b5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/00ca8b563a69aa77c035bdbb9636ada4d6ef5af0))
* **CONTRIBUTING:** add release instructions ([83fd3a5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/83fd3a5bbdfaff827551fd069b8445ca3109d9ad))
* **CONTRIBUTING:** add Xcode details ([757b1cc](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/757b1cc13d679d710be8366f9e74a69a8e0e89a7))
* **CONTRIBUTING:** remove swiftformat ([373a757](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/373a75710ff78a16d829be39e2f84a9263baa72c))
* correct doc format ([981233c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/981233c6f0e0fcc235e8b466fa26c3756f89e03d))
* regenerate SourceDocs ([9d0b70d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9d0b70d781881e5b2688b40d29a7e372068f696c))
* remove header ([746f77c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/746f77c3a088da2eed26f9283435b348e4ba87f0))
* **sdk:** generate new sourcedocs documentation ([ec90c12](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ec90c1299da47ab3309b4992aec2adee0c00409a))
* **SECURITY:** update release version ([9e6d457](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9e6d457eb24db1d04d37ae49af621e911b9969af))
* **SECURITY:** update version matrix ([03c6e73](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/03c6e733211e1793b0a4b53c91f272e3129dddcb))
* **SECURITY:** update version matrix ([a4cef26](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a4cef260fe2566dcb179566a6965a504f1792a32))
* update API documentation ([8d885c5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8d885c54fc52c5a53e76b76d9a61e2f3d937fbf5))
* update README.md ([70e6bb2](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/70e6bb26481526ed9244bd60531af990e8a93e82))
* update repository references ([f449a25](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f449a250ed77cb5e4af9c66d7d9ffd592c2d3afe))
* update repository references ([248bfaa](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/248bfaa4b034ef42cf4c559effcff1eceecffdbb))
* update repository references ([31f612c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/31f612c98f75b5be41f689cb9b5ce9bfd4797e4b))
* update SourceDocs ([e1f6e14](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/e1f6e144750a882dc9004bf672391f1fa1887db1))

## [1.1.0](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v1.1.0-rc...v1.1.0) (2026-03-04)

### Features

* Add client_id as a logout option ([3fd8de7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3fd8de7038a76f12de775c1734b3c023be728be5))


## [1.1.0-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v1.0.0-rc...v1.1.0-rc) (2026-03-04)

### Features

* Add client_id as a logout option ([3fd8de7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3fd8de7038a76f12de775c1734b3c023be728be5))


## [1.0.0](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.3.0...v1.0.0) (2026-01-31)

### Features

* **feat:** bump swift to 6.x and xcode 26.0.1 ([#103](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/103))
* **feat:** Add way to clear all AuthorizationManager state ([#112](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/112))


### Bug Fixes

* **deps:** bump github.com/openid/appauth-ios from 1.7.6 to 2.0.0 ([#71](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/71)) ([eb43ca5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/eb43ca5fd1306f5c76e975563ef0b68b6dd705de))
* **fix:** Ensure the tenant id is set for well known configuration ([#111](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/111
))
* **fix:** end to end tests are failing when starting a pre-release ([#116](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/116))


### Miscellaneous Chores
* sync release manifests ([d540687](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d540687c63c25e438d44071516962ebd18e18e07))


### Build System and Dependencies

* **deps:** bump fusionauth/fusionauth-app ([#56](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/56)) ([6934ecf](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/6934ecfafabf0bd2b9a45620e801ac80f0b3edf3))
* **deps:** bump fusionauth/fusionauth-app ([#64](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/64)) ([486d799](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/486d799a10fb03e3544c32d310730127272c3f16))
* **deps:** bump fusionauth/fusionauth-app ([#74](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/74)) ([d2fc0b0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d2fc0b0782276b6caac2025066dd5c94ac4f448e))
* **deps:** bump github.com/realm/swiftlint ([8f2e98a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8f2e98aaf4db05dc94145dc5c696b26e973d8b6f))
* **deps:** bump github.com/realm/swiftlint ([aa658b9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/aa658b980778db03a8a83fb4f522562b05172dc9))
* **deps:** bump github.com/realm/swiftlint ([#62](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/62)) ([0b89eea](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0b89eea7ec713be8310902d689929a0a8c9f6146))
* **deps:** bump github.com/realm/swiftlint ([#68](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/68)) ([d7dd34c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d7dd34c73068273d9b36efbcd3d945111dc8f90b))
* **deps:** bump github.com/realm/swiftlint from 0.59.1 to 0.60.0 in the gradle-minor-dependencies group ([59271ab](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/59271abeae80f880597ca128fa3352e6bcb504b0))
* **deps:** bump github.com/realm/swiftlint from 0.63.0 to 0.63.1 in the gradle-minor-dependencies group ([5b5c3a8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5b5c3a82db47b70ae2df7e9e5bd549a1ac9b531e))
* **deps:** bump github/codeql-action in the prod-github-actions group ([181b53a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/181b53a66b5b1baed87e3ff171b2c5dc381d0738))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#46](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/46)) ([93e59ae](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93e59ae379b62e38417501a1b23a94883255434e))
* **deps:** bump multiple dependencies ([#69](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/69)) ([941483e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/941483ed7cab93cc3fcdfce5a4a6e3b37b85eb75))
* **deps:** bump opensearchproject/opensearch ([#47](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/47)) ([00848a7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/00848a74e7b7fc2c1b84f277c8269f1387095f13))
* **deps:** bump opensearchproject/opensearch ([#54](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/54)) ([0677dd8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0677dd8b55a34d66c379e099b1cbebfb2a3a76ee))
* **deps:** bump opensearchproject/opensearch ([#78](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/78)) ([c66166a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c66166a1af4d614a5a5440c06e13061bdf802181))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#49](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/49)) ([868793d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/868793df1cd004e21fbb57ce09b48c0c5fc4d957))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#50](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/50)) ([dd76580](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/dd765805e6d4c0374ceebeeb67d497fe20a1b2f0))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#80](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/80)) ([a1eb4e9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a1eb4e98b721d6cf78cf1803f0fb7cfcb097e101))
* **deps:** bump swift to 6.1.1 ([51a1900](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/51a1900e6491ffda76072b00f1af11616b1dbff3))
* **deps:** bump swift-actions/setup-swift ([#82](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/82)) ([3be89d7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3be89d703effa56899c2df2aa0c91b645cf301af))
* **deps:** bump swift, xcode, and simulator-version ([daac87a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/daac87a49c1c34ba6f89e762fab03a55bc1eb5d5))
* **deps:** bump the prod-github-actions group across 1 directory with 3 updates ([#55](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/55)) ([06f8627](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/06f862785bfde3a177ef3237abfda9529017d308))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([ba93df1](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ba93df13cc0711a6047f79bc677a7e9ca08250f2))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([930d5d6](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/930d5d646be5a55bc232fca564a1b68de3201c93))


### Docs

* update repository references ([f449a25](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f449a250ed77cb5e4af9c66d7d9ffd592c2d3afe))
* update repository references ([248bfaa](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/248bfaa4b034ef42cf4c559effcff1eceecffdbb))
* update repository references ([31f612c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/31f612c98f75b5be41f689cb9b5ce9bfd4797e4b))

## [1.0.0-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.3.0...v1.0.0-rc) (2026-01-31)

### Features

* **feat:** bump swift to 6.x and xcode 26.0.1 ([#103](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/103))
* **feat:** Add way to clear all AuthorizationManager state ([#112](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/112))


### Bug Fixes

* **deps:** bump github.com/openid/appauth-ios from 1.7.6 to 2.0.0 ([#71](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/71)) ([eb43ca5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/eb43ca5fd1306f5c76e975563ef0b68b6dd705de))
* **fix:** Ensure the tenant id is set for well known configuration ([#111](https://github.com/FusionAuth/fusionauth-swift-sdk/pull/111))
* **fix:** end to end tests are failing when starting a pre-release ([#116](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/116))


### Miscellaneous Chores
* sync release manifests ([d540687](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d540687c63c25e438d44071516962ebd18e18e07))


### Build System and Dependencies

* **deps:** bump fusionauth/fusionauth-app ([#56](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/56)) ([6934ecf](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/6934ecfafabf0bd2b9a45620e801ac80f0b3edf3))
* **deps:** bump fusionauth/fusionauth-app ([#64](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/64)) ([486d799](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/486d799a10fb03e3544c32d310730127272c3f16))
* **deps:** bump fusionauth/fusionauth-app ([#74](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/74)) ([d2fc0b0](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d2fc0b0782276b6caac2025066dd5c94ac4f448e))
* **deps:** bump github.com/realm/swiftlint ([8f2e98a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8f2e98aaf4db05dc94145dc5c696b26e973d8b6f))
* **deps:** bump github.com/realm/swiftlint ([aa658b9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/aa658b980778db03a8a83fb4f522562b05172dc9))
* **deps:** bump github.com/realm/swiftlint ([#62](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/62)) ([0b89eea](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0b89eea7ec713be8310902d689929a0a8c9f6146))
* **deps:** bump github.com/realm/swiftlint ([#68](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/68)) ([d7dd34c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/d7dd34c73068273d9b36efbcd3d945111dc8f90b))
* **deps:** bump github.com/realm/swiftlint from 0.59.1 to 0.60.0 in the gradle-minor-dependencies group ([59271ab](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/59271abeae80f880597ca128fa3352e6bcb504b0))
* **deps:** bump github.com/realm/swiftlint from 0.63.0 to 0.63.1 in the gradle-minor-dependencies group ([5b5c3a8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/5b5c3a82db47b70ae2df7e9e5bd549a1ac9b531e))
* **deps:** bump github/codeql-action in the prod-github-actions group ([181b53a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/181b53a66b5b1baed87e3ff171b2c5dc381d0738))
* **deps:** bump github/codeql-action in the prod-github-actions group ([#46](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/46)) ([93e59ae](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93e59ae379b62e38417501a1b23a94883255434e))
* **deps:** bump multiple dependencies ([#69](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/69)) ([941483e](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/941483ed7cab93cc3fcdfce5a4a6e3b37b85eb75))
* **deps:** bump opensearchproject/opensearch ([#47](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/47)) ([00848a7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/00848a74e7b7fc2c1b84f277c8269f1387095f13))
* **deps:** bump opensearchproject/opensearch ([#54](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/54)) ([0677dd8](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/0677dd8b55a34d66c379e099b1cbebfb2a3a76ee))
* **deps:** bump opensearchproject/opensearch ([#78](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/78)) ([c66166a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/c66166a1af4d614a5a5440c06e13061bdf802181))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#49](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/49)) ([868793d](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/868793df1cd004e21fbb57ce09b48c0c5fc4d957))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#50](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/50)) ([dd76580](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/dd765805e6d4c0374ceebeeb67d497fe20a1b2f0))
* **deps:** bump postgres in /Samples/Quickstart/fusionauth/latest ([#80](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/80)) ([a1eb4e9](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a1eb4e98b721d6cf78cf1803f0fb7cfcb097e101))
* **deps:** bump swift to 6.1.1 ([51a1900](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/51a1900e6491ffda76072b00f1af11616b1dbff3))
* **deps:** bump swift-actions/setup-swift ([#82](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/82)) ([3be89d7](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/3be89d703effa56899c2df2aa0c91b645cf301af))
* **deps:** bump swift, xcode, and simulator-version ([daac87a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/daac87a49c1c34ba6f89e762fab03a55bc1eb5d5))
* **deps:** bump the prod-github-actions group across 1 directory with 3 updates ([#55](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/55)) ([06f8627](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/06f862785bfde3a177ef3237abfda9529017d308))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([ba93df1](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/ba93df13cc0711a6047f79bc677a7e9ca08250f2))
* **deps:** bump the prod-github-actions group across 1 directory with 6 updates ([930d5d6](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/930d5d646be5a55bc232fca564a1b68de3201c93))


### Docs

* update repository references ([f449a25](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/f449a250ed77cb5e4af9c66d7d9ffd592c2d3afe))
* update repository references ([248bfaa](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/248bfaa4b034ef42cf4c559effcff1eceecffdbb))
* update repository references ([31f612c](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/31f612c98f75b5be41f689cb9b5ce9bfd4797e4b))

## [0.3.0](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.2.0...v0.3.0) (2025-02-07)


### Features

* add, test and verify macos-15, xcode-16.1 and swift-6.0.2 compatibility ([#22](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/22)) ([de49b36](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/de49b362ec9cf0b6839536e283d4af96f275ee12))


### Bug Fixes

* **deps:** bump the prod-github-actions group with 2 updates ([#40](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/40)) ([cd9bfac](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/cd9bfac23b946a1735911bb9ed634f21a3ae8ce1))
* **e2e-test:** use main for fusionauth-docker-image-version ([bd4bf06](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/bd4bf06479d62fb010977f67ca793936df4d99c5))
* **e2e-test:** use main for fusionauth-docker-image-version ([9732d7a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9732d7af7b8b3744ebe5f91095fe0a14c504ec93))
* **release:** add PR label job as temporary fix for missing labels ([fb3c416](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/fb3c41614f4b377c9c0ff43283608b82c23de83e))

## [0.3.0-rc.1](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.3.0-rc...v0.3.0-rc.1) (2025-02-07)


### Bug Fixes

* **e2e-test:** use main for fusionauth-docker-image-version ([bd4bf06](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/bd4bf06479d62fb010977f67ca793936df4d99c5))
* **e2e-test:** use main for fusionauth-docker-image-version ([9732d7a](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/9732d7af7b8b3744ebe5f91095fe0a14c504ec93))

## [0.3.0-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.2.0...v0.3.0-rc) (2025-02-07)


### Features

* add, test and verify macos-15, xcode-16.1 and swift-6.0.2 compatibility ([#22](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/22)) ([de49b36](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/de49b362ec9cf0b6839536e283d4af96f275ee12))


### Bug Fixes

* **deps:** bump the prod-github-actions group with 2 updates ([#40](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/40)) ([cd9bfac](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/cd9bfac23b946a1735911bb9ed634f21a3ae8ce1))
* **release:** add PR label job as temporary fix for missing labels ([fb3c416](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/fb3c41614f4b377c9c0ff43283608b82c23de83e))

## [0.2.0](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.1.1...v0.2.0) (2025-01-22)


### Features

* **release:** use workflow_run instead of inherited job ([#36](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/36)) ([93f1f41](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93f1f41cc49890839a78b3c051f58c271918f739))


### Bug Fixes

* **release:** add dependency to initial tests ([8ede5d5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8ede5d5d1043bf9a182a198113658453bdcc01c3))
* **release:** only allow release flow to trigger when workflow_run.conclusion is successful ([b3e8b40](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b3e8b40d6d30d76025c5fecf5d06b6b3f38288a1))
* **release:** remove workflow_run and use workflow include instead ([46aafa3](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/46aafa388aa25cf6c188d572b0766a6051bc81f9))

## [0.2.0-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.1.1...v0.2.0-rc) (2025-01-22)


### Features

* **release:** use workflow_run instead of inherited job ([#36](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/36)) ([93f1f41](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/93f1f41cc49890839a78b3c051f58c271918f739))


### Bug Fixes

* **release:** add dependency to initial tests ([8ede5d5](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/8ede5d5d1043bf9a182a198113658453bdcc01c3))
* **release:** only allow release flow to trigger when workflow_run.conclusion is successful ([b3e8b40](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/b3e8b40d6d30d76025c5fecf5d06b6b3f38288a1))
* **release:** remove workflow_run and use workflow include instead ([46aafa3](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/46aafa388aa25cf6c188d572b0766a6051bc81f9))

## [0.1.1](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.1.0...v0.1.1) (2025-01-16)


### Bug Fixes

* remove codeChallenge and codeChallengeMethod ([a0f233b](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a0f233b1781b6188285c433a8a54ee2c62f3f9cb)), closes [#25](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/25)

## [0.1.1-rc](https://github.com/FusionAuth/fusionauth-swift-sdk/compare/v0.1.0...v0.1.1-rc) (2025-01-16)


### Bug Fixes

* remove codeChallenge and codeChallengeMethod ([a0f233b](https://github.com/FusionAuth/fusionauth-swift-sdk/commit/a0f233b1781b6188285c433a8a54ee2c62f3f9cb)), closes [#25](https://github.com/FusionAuth/fusionauth-swift-sdk/issues/25)
