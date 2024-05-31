# typed: strict

# The type aliases declared in rbi/ohm.rbi can in fact be referenced from an app
# that uses Ohm. However, this does not seem to be the case for test Dummy app,
# so we work around the issue by mirroring those aliases here.
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
