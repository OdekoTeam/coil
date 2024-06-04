# typed: strict

class Dummy::Outbox::FooMessage < Coil::Outbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Outbox::FooMessagesJob)) }
  def job_class
    Dummy::Outbox::FooMessagesJob
  end
end
