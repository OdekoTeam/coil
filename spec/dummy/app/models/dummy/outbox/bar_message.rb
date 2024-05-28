# typed: strict

class Dummy::Outbox::BarMessage < Ohm::Outbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Outbox::BarMessagesJob)) }
  def job_class
    Dummy::Outbox::BarMessagesJob
  end
end
