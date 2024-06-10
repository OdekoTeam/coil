# typed: strict

class Dummy::Inbox::WhoMessage < Coil::Inbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Inbox::WhoMessagesJob)) }
  def job_class
    Dummy::Inbox::WhoMessagesJob
  end
end
