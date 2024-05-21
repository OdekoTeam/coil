class Dummy::Inbox::BarMessage < Ohm::Inbox::Message
  def job_class
    Dummy::Inbox::BarMessagesJob
  end
end
