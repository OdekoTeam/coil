# typed: strict

# The type aliases declared in rbi/coil.rbi can in fact be referenced from an
# app that uses Coil. However, this does not seem to be the case for test Dummy
# app, so we work around the issue by mirroring those aliases here.
module TypeAliases
  AnyMessage = T.type_alias {
    T.any(
      ::Coil::Inbox::Message,
      ::Coil::Outbox::Message
    )
  }
  AnyMessageClass = T.type_alias {
    T.any(
      T.class_of(::Coil::Inbox::Message),
      T.class_of(::Coil::Outbox::Message)
    )
  }
end
