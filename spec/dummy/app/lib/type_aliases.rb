# typed: strict

module TypeAliases
  AnyMessage = T.type_alias {
    T.any(
      ::Ohm::Inbox::Message,
      ::Ohm::Outbox::Message
    )
  }
  AnyMessageClass = T.type_alias {
    T.any(
      T.class_of(::Ohm::Inbox::Message),
      T.class_of(::Ohm::Outbox::Message)
    )
  }
end
