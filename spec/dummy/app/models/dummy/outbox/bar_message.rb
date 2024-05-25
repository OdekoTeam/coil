class Dummy::Outbox::BarMessage < Ohm::Outbox::Message
  def job_class
    Dummy::Outbox::BarMessagesJob
  end
end
