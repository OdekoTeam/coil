# typed: strict

class Dummy::Inbox::FooMessage < Ohm::Inbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Inbox::FooMessagesJob)) }
  def job_class
    Dummy::Inbox::FooMessagesJob
  end
end
