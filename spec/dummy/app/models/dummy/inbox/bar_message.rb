# typed: strict

class Dummy::Inbox::BarMessage < Coil::Inbox::Message
  extend T::Sig

  sig { override.returns(T.class_of(Dummy::Inbox::BarMessagesJob)) }
  def job_class
    Dummy::Inbox::BarMessagesJob
  end
end
