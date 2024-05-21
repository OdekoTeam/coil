class Dummy::Inbox::FooMessage < Ohm::Inbox::Message
  def job_class
    Dummy::Inbox::FooMessagesJob
  end
end
