# typed: strict

class Dummy::Outbox::FooMessage < Ohm::Outbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Outbox::FooMessagesJob)) }
  def job_class
    Dummy::Outbox::FooMessagesJob
  end
end
