# typed: strict

# The type aliases declared in rbi/coil.rbi are visible during static type
# checks, but not during runtime checks. We work around that here by mirroring
# them, allowing the Dummy app to write concise method signatures without
# breaking its runtime checks.
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
