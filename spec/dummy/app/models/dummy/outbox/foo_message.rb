class Dummy::Outbox::FooMessage < Ohm::Outbox::Message
  def job_class
    Dummy::Outbox::FooMessagesJob
  end
end
