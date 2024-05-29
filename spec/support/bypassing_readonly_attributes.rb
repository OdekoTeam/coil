module BypassingReadOnlyAttributes
  def bypassing_readonly_attributes(model)
    allow(model).to receive(:readonly_attribute?).and_return(false)
    yield
    allow(model).to receive(:readonly_attribute?).and_call_original
  end
end
