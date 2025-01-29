## main

## [1.5.5](https://github.com/OdekoTeam/coil/compare/1.5.4...1.5.5) (2025-03-24)
#### Added
- Rails 8 support ([bcc6885](https://github.com/OdekoTeam/coil/commit/bcc6885bdbe3a7dedbc505edee0482d215fe9d91))

## [1.5.4](https://github.com/OdekoTeam/coil/compare/1.5.3...1.5.4) (2025-03-24)
#### Added
- Rails 7.2 support ([be1cdc4](https://github.com/OdekoTeam/coil/commit/be1cdc4bde1fb73d1ac24f3b786a1d58a748d87f))

## [1.5.3](https://github.com/OdekoTeam/coil/compare/1.5.2...1.5.3) (2025-03-24)
#### Added
- Ruby 3.2 and 3.3 support ([a4ceb7c](https://github.com/OdekoTeam/coil/commit/a4ceb7cf2cefc47ae3c14a876a0782aaec0e5c43))

## [1.5.2](https://github.com/OdekoTeam/coil/compare/1.5.1...1.5.2) (2025-03-19)
#### Fixed
- Fix support for Rails versions older than 6.1.0 ([0afd25b](https://github.com/OdekoTeam/coil/commit/0afd25bf1f47371e47f3787daf81caab8b676646))

## [1.5.1](https://github.com/OdekoTeam/coil/compare/1.5.0...1.5.1) (2025-01-29)
#### Fixed
- Avoid `ActiveRecord::SubclassNotFound` on orphaned messages ([ea3a64a](https://github.com/OdekoTeam/coil/commit/ea3a64acfcb9f05d53e242f96eb1b525761e414d))

## [1.5.0](https://github.com/OdekoTeam/coil/compare/1.4.0...1.5.0) (2025-01-29)
#### Added
- Periodic cleanup jobs ([0e784b3](https://github.com/OdekoTeam/coil/commit/0e784b3684b8e12677e6d05bc0a7762e254e6357))
  - jobs: `Coil::Inbox::MessagesCleanupJob`, `Coil::Outbox::MessagesCleanupJob`
  - configuration settings: `Coil.inbox_retention_period`, `Coil.outbox_retention_period`
  - **NOTE**: this release includes additional migrations, so **be sure to run** `bundle exec rails coil:install:migrations db:migrate`

## [1.4.0](https://github.com/OdekoTeam/coil/compare/1.3.3...1.4.0) (2024-12-11)
#### Added
- `Coil.sidekiq_queue` configuration setting ([15fb072](https://github.com/OdekoTeam/coil/commit/15fb072284bad1eeb5661d3b037d3e07bb46c59a))
#### Fixed
- Redundant variable in test ([cd41472](https://github.com/OdekoTeam/coil/commit/cd414726298ce80153f508f755bedd371bbb8dab))

## [1.3.3](https://github.com/OdekoTeam/coil/compare/1.3.2...1.3.3) (2024-10-25)
#### Changed
- Documentation ([b25f00c](https://github.com/OdekoTeam/coil/commit/b25f00c19dfdb4cd3653ce715ace0be3145046e9))

## [1.3.2](https://github.com/OdekoTeam/coil/compare/1.3.1...1.3.2) (2024-10-24)
#### Fixed
- Build warnings ([f1c1145](https://github.com/OdekoTeam/coil/commit/f1c11459b5b54567c0b267ae6279f776ec33a680))

## [1.3.1](https://github.com/OdekoTeam/coil/compare/1.3.0...1.3.1) (2024-10-22)
#### Added
- CI publish to RubyGems.org ([cbc46bb](https://github.com/OdekoTeam/coil/commit/cbc46bbc153d1a7fa9d51dbf134dabe894cd594d))

## [1.3.0](https://github.com/OdekoTeam/coil/compare/1.2.1...1.3.0) (2024-10-22)
#### Added
- License ([caf8a2f](https://github.com/OdekoTeam/coil/commit/caf8a2ff68672f434eeb092e876bb6df8852b6b1))
#### Changed
- CI Docker registry ([1a2586d](https://github.com/OdekoTeam/coil/commit/1a2586db9541134c1e433d112591457a6ee9edc0))

## [1.2.1](https://github.com/OdekoTeam/coil/compare/1.2.0...1.2.1) (2024-07-01)
#### Fixed
- `next_message` race condition ([eb43a90](https://github.com/OdekoTeam/coil/commit/eb43a900c2db4300fc41c6c874aca66868039718))

## [1.2.0](https://github.com/OdekoTeam/coil/compare/1.0.1...1.2.0) (2024-06-10)
#### Added
- `around_process` job method ([46d3d5b](https://github.com/OdekoTeam/coil/commit/46d3d5b53f6dd066d5add024f39120c6140c14f3))
#### Fixed
- type aliases documentation ([d5da8d1](https://github.com/OdekoTeam/coil/commit/d5da8d13de6ac6fa9df6ba7c281db86090358f7f))

## [1.0.1](https://github.com/OdekoTeam/coil/compare/1.0.0...1.0.1) (2024-06-07)
#### Fixed
- `QueueLocking` documentation ([285a5cb](https://github.com/OdekoTeam/coil/commit/285a5cb13bffa3b824c54b59c02be2bbad93bef4))
- Support for older Rails and Sidekiq versions ([2051243](https://github.com/OdekoTeam/coil/commit/205124313b75feaf42aac10aa7455bc54a2394f0))
#### Changed
- CI Docker image ([4da1d3f](https://github.com/OdekoTeam/coil/commit/4da1d3ffdf8bb8fe03d14466ae26640159942bca))

## 1.0.0 (2024-06-06)
#### Added
- First release
