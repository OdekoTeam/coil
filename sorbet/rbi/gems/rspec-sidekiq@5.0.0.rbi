# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rspec-sidekiq` gem.
# Please instead update this file by running `bin/tapioca gem rspec-sidekiq`.


# source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#4
module RSpec
  class << self
    # source://rspec-core/3.13.0/lib/rspec/core.rb#70
    def clear_examples; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#85
    def configuration; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#49
    def configuration=(_arg0); end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#97
    def configure; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#194
    def const_missing(name); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def context(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#122
    def current_example; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#128
    def current_example=(example); end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#154
    def current_scope; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#134
    def current_scope=(scope); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def describe(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def example_group(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def fcontext(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def fdescribe(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#58
    def reset; end

    # source://rspec-core/3.13.0/lib/rspec/core/shared_example_group.rb#110
    def shared_context(name, *args, &block); end

    # source://rspec-core/3.13.0/lib/rspec/core/shared_example_group.rb#110
    def shared_examples(name, *args, &block); end

    # source://rspec-core/3.13.0/lib/rspec/core/shared_example_group.rb#110
    def shared_examples_for(name, *args, &block); end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#160
    def world; end

    # source://rspec-core/3.13.0/lib/rspec/core.rb#49
    def world=(_arg0); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def xcontext(*args, &example_group_block); end

    # source://rspec-core/3.13.0/lib/rspec/core/dsl.rb#42
    def xdescribe(*args, &example_group_block); end
  end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#5
module RSpec::Sidekiq
  class << self
    # source://rspec-sidekiq//lib/rspec/sidekiq/sidekiq.rb#8
    def configuration; end

    # @yield [configuration]
    #
    # source://rspec-sidekiq//lib/rspec/sidekiq/sidekiq.rb#4
    def configure(&block); end
  end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#6
class RSpec::Sidekiq::Configuration
  # @return [Configuration] a new instance of Configuration
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#11
  def initialize; end

  # Returns the value of attribute clear_all_enqueued_jobs.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def clear_all_enqueued_jobs; end

  # Sets the attribute clear_all_enqueued_jobs
  #
  # @param value the value to set the attribute clear_all_enqueued_jobs to.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def clear_all_enqueued_jobs=(_arg0); end

  # Returns the value of attribute enable_terminal_colours.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def enable_terminal_colours; end

  # Sets the attribute enable_terminal_colours
  #
  # @param value the value to set the attribute enable_terminal_colours to.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def enable_terminal_colours=(_arg0); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#21
  def sidekiq_gte_7?; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#25
  def silence_warning(symbol); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#29
  def warn_for?(symbol); end

  # Returns the value of attribute warn_when_jobs_not_processed_by_sidekiq.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def warn_when_jobs_not_processed_by_sidekiq; end

  # Sets the attribute warn_when_jobs_not_processed_by_sidekiq
  #
  # @param value the value to set the attribute warn_when_jobs_not_processed_by_sidekiq to.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/configuration.rb#7
  def warn_when_jobs_not_processed_by_sidekiq=(_arg0); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#3
module RSpec::Sidekiq::Matchers
  include ::RSpec::Mocks::ArgumentMatchers

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#6
  def be_delayed(*expected_arguments); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#4
  def be_expired_in(expected_argument); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#4
  def be_processed_in(expected_queue); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#4
  def be_retryable(expected_retry); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#4
  def be_unique; end

  # Passes if a Job is enqueued as the result of a block. Chainable `with`
  # for arguments, `on` for queue, `at` for queued for a specific time, and
  # `in` for a specific interval delay to being queued, `immediately` for
  # queued without delay.
  #
  # @api public
  # @example
  #
  #   expect { AwesomeJob.perform_async }.to enqueue_sidekiq_job
  #
  #   # A specific job class
  #   expect { AwesomeJob.perform_async }.to enqueue_sidekiq_job(AwesomeJob)
  #
  #   # with specific arguments
  #   expect { AwesomeJob.perform_async "Awesome!" }.to enqueue_sidekiq_job.with("Awesome!")
  #
  #   # On a specific queue
  #   expect { AwesomeJob.set(queue: "high").perform_async }.to enqueue_sidekiq_job.on("high")
  #
  #   # At a specific datetime
  #   specific_time = 1.hour.from_now
  #   expect { AwesomeJob.perform_at(specific_time) }.to enqueue_sidekiq_job.at(specific_time)
  #
  #   # In a specific interval (be mindful of freezing or managing time here)
  #   freeze_time do
  #   expect { AwesomeJob.perform_in(1.hour) }.to enqueue_sidekiq_job.in(1.hour)
  #   end
  #
  #   # Without any delay
  #   expect { AwesomeJob.perform_async }.to enqueue_sidekiq_job.immediately
  #   expect { AwesomeJob.perform_at(1.hour.ago) }.to enqueue_sidekiq_job.immediately
  #
  #   ## Composable
  #
  #   expect do
  #   AwesomeJob.perform_async
  #   OtherJob.perform_async
  #   end.to enqueue_sidekiq_job(AwesomeJob).and enqueue_sidekiq_job(OtherJob)
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#81
  def enqueue_sidekiq_job(job_class = T.unsafe(nil)); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/have_enqueued_sidekiq_job.rb#4
  def have_enqueued_sidekiq_job(*expected_arguments); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#4
  def save_backtrace(expected_backtrace = T.unsafe(nil)); end
end

# @api private
#
# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#174
class RSpec::Sidekiq::Matchers::Base
  include ::RSpec::Mocks::ArgumentMatchers
  include ::RSpec::Matchers::Composable

  # @api private
  # @return [Base] a new instance of Base
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#180
  def initialize; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#178
  def actual_jobs; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#191
  def at(timestamp); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#231
  def at_least(n); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#236
  def at_most(n); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#296
  def common_message; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#304
  def count_message; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#258
  def description; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#226
  def exactly(n); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#178
  def expected_arguments; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#178
  def expected_count; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#178
  def expected_options; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#262
  def failure_message; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#315
  def failure_message_when_negated; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#322
  def formatted(thing); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#201
  def immediately; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#196
  def in(interval); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#178
  def klass; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#326
  def normalize_arguments(args); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#206
  def on(queue); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#211
  def once; end

  # @api private
  # @raise [NotImplementedError]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#300
  def prefix_message; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#246
  def set_expected_count(relativity, n); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#221
  def thrice; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#241
  def time; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#241
  def times; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#216
  def twice; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#186
  def with(*expected_arguments); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#10
class RSpec::Sidekiq::Matchers::BeDelayed
  # @return [BeDelayed] a new instance of BeDelayed
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#11
  def initialize(*expected_arguments); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#19
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#27
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#54
  def failure_message_when_negated; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#31
  def for(interval); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#36
  def matches?(expected_method); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#58
  def until(time); end

  private

  # @yield [job]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_delayed.rb#65
  def find_job(method, arguments, &block); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#8
class RSpec::Sidekiq::Matchers::BeExpiredIn
  # @return [BeExpiredIn] a new instance of BeExpiredIn
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#9
  def initialize(expected_argument); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#13
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#17
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#21
  def failure_message_when_negated; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_expired_in.rb#25
  def matches?(job); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#8
class RSpec::Sidekiq::Matchers::BeProcessedIn
  # @return [BeProcessedIn] a new instance of BeProcessedIn
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#9
  def initialize(expected_queue); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#13
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#17
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#31
  def failure_message_when_negated; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_processed_in.rb#21
  def matches?(job); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#8
class RSpec::Sidekiq::Matchers::BeRetryable
  # @return [BeRetryable] a new instance of BeRetryable
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#9
  def initialize(expected_retry); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#13
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#23
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#33
  def failure_message_when_negated; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_retryable.rb#27
  def matches?(job); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#8
class RSpec::Sidekiq::Matchers::BeUnique
  class << self
    # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#9
    def new; end
  end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#19
class RSpec::Sidekiq::Matchers::BeUnique::Base
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#20
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#24
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#52
  def failure_message_when_negated; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#39
  def for(interval); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#48
  def interval_matches?; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#44
  def interval_specified?; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#33
  def matches?(job); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#71
class RSpec::Sidekiq::Matchers::BeUnique::SidekiqEnterprise < ::RSpec::Sidekiq::Matchers::BeUnique::Base
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#72
  def actual_interval; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#80
  def unique_key; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#76
  def value_matches?; end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#57
class RSpec::Sidekiq::Matchers::BeUnique::SidekiqUniqueJobs < ::RSpec::Sidekiq::Matchers::BeUnique::Base
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#58
  def actual_interval; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#66
  def unique_key; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/be_unique.rb#62
  def value_matches?; end
end

# @api private
#
# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#5
class RSpec::Sidekiq::Matchers::EnqueueSidekiqJob < ::RSpec::Sidekiq::Matchers::Base
  # @api private
  # @return [EnqueueSidekiqJob] a new instance of EnqueueSidekiqJob
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#8
  def initialize(job_class); end

  # @api private
  # @raise [ArgumentError]
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#19
  def matches?(proc); end

  # Plus that from Base
  #
  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#6
  def original_jobs; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#33
  def prefix_message; end

  # @api private
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/enqueue_sidekiq_job.rb#37
  def supports_block_expectations?; end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#84
class RSpec::Sidekiq::Matchers::EnqueuedJob
  extend ::Forwardable

  # @return [EnqueuedJob] a new instance of EnqueuedJob
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#89
  def initialize(job); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#105
  def ==(other); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def [](*args, **_arg1, &block); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#97
  def args; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#101
  def context; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#105
  def eql?(other); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#93
  def jid; end

  # Returns the value of attribute job.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#86
  def job; end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#113
class RSpec::Sidekiq::Matchers::EnqueuedJobs
  include ::Enumerable

  # @return [EnqueuedJobs] a new instance of EnqueuedJobs
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#117
  def initialize(klass); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#136
  def each(&block); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#121
  def includes?(arguments, options, count); end

  # Returns the value of attribute jobs.
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#115
  def jobs; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#140
  def minus!(other); end

  private

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#155
  def arguments_matches?(job, arguments); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#150
  def matches?(job, arguments, options); end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#161
  def options_matches?(job, options); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#167
  def unwrap_jobs(jobs); end
end

# @api private
#
# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/have_enqueued_sidekiq_job.rb#9
class RSpec::Sidekiq::Matchers::HaveEnqueuedSidekiqJob < ::RSpec::Sidekiq::Matchers::Base
  # @api private
  # @return [HaveEnqueuedSidekiqJob] a new instance of HaveEnqueuedSidekiqJob
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/have_enqueued_sidekiq_job.rb#10
  def initialize(expected_arguments); end

  # @api private
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/have_enqueued_sidekiq_job.rb#15
  def matches?(job_class); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/have_enqueued_sidekiq_job.rb#27
  def prefix_message; end
end

# @api private
#
# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#36
class RSpec::Sidekiq::Matchers::JobArguments
  include ::RSpec::Mocks::ArgumentMatchers

  # @api private
  # @return [JobArguments] a new instance of JobArguments
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#39
  def initialize(job); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#42
  def job; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#42
  def job=(_arg0); end

  # @api private
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#44
  def matches?(expected_args); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#50
  def unwrapped_arguments; end

  private

  # @api private
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#60
  def active_job?; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#77
  def active_job_original_args; end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#64
  def deserialized_active_job_args; end
end

# @api private
#
# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#5
class RSpec::Sidekiq::Matchers::JobOptionParser
  # @api private
  # @return [JobOptionParser] a new instance of JobOptionParser
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#8
  def initialize(job); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#6
  def job; end

  # @api private
  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#12
  def matches?(options); end

  private

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#18
  def at_evaluator(value); end

  # @api private
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/base.rb#23
  def with_context(**expected_context); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#8
class RSpec::Sidekiq::Matchers::SaveBacktrace
  # @return [SaveBacktrace] a new instance of SaveBacktrace
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#9
  def initialize(expected_backtrace = T.unsafe(nil)); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#13
  def description; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#23
  def failure_message; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#33
  def failure_message_when_negated; end

  # @return [Boolean]
  #
  # source://rspec-sidekiq//lib/rspec/sidekiq/matchers/save_backtrace.rb#27
  def matches?(job); end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#1
module Sidekiq
  class << self
    # source://sidekiq/7.2.4/lib/sidekiq.rb#134
    def configure_client; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#122
    def configure_embed(&block); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#96
    def configure_server(&block); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#88
    def default_configuration; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#84
    def default_job_options; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#80
    def default_job_options=(hash); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#56
    def dump_json(object); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#64
    def ent?; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#101
    def freeze!; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#52
    def load_json(string); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#92
    def logger; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#60
    def pro?; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#72
    def redis(&block); end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#68
    def redis_pool; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#48
    def server?; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#76
    def strict_args!(mode = T.unsafe(nil)); end

    # source://sidekiq/7.2.4/lib/sidekiq/transaction_aware_client.rb#40
    def transactional_push!; end

    # source://sidekiq/7.2.4/lib/sidekiq.rb#44
    def ❨╯°□°❩╯︵┻━┻; end
  end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#2
module Sidekiq::Job
  include ::Sidekiq::Job::Options

  mixes_in_class_methods ::Sidekiq::Job::Options::ClassMethods
  mixes_in_class_methods ::Sidekiq::Job::ClassMethods

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#156
  def jid; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#156
  def jid=(_arg0); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#165
  def logger; end

  class << self
    # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#305
    def clear_all; end

    # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#310
    def drain_all; end

    # source://sidekiq/7.2.4/lib/sidekiq/job.rb#158
    def included(base); end

    # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#300
    def jobs; end
  end
end

# source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#3
module Sidekiq::Job::ClassMethods
  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#367
  def build_client; end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#264
  def clear; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#352
  def client_push(item); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#18
  def default_retries_exhausted_exception; end

  # source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#9
  def default_retries_exhausted_message; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#265
  def delay(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#269
  def delay_for(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#273
  def delay_until(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#269
  def drain; end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#294
  def execute_job(worker, args); end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#259
  def jobs; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#285
  def perform_async(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#321
  def perform_at(interval, *args); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#315
  def perform_bulk(*args, **kwargs); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#321
  def perform_in(interval, *args); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#290
  def perform_inline(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#278
  def perform_one; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#290
  def perform_sync(*args); end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#285
  def process_job(job); end

  # source://sidekiq/7.2.4/lib/sidekiq/testing.rb#254
  def queue; end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#277
  def queue_as(q); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#281
  def set(options); end

  # source://sidekiq/7.2.4/lib/sidekiq/job.rb#348
  def sidekiq_options(opts = T.unsafe(nil)); end

  # source://rspec-sidekiq//lib/rspec/sidekiq/helpers/within_sidekiq_retries_exhausted_block.rb#4
  def within_sidekiq_retries_exhausted_block(user_msg = T.unsafe(nil), exception = T.unsafe(nil), &block); end
end