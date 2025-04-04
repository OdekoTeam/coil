# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `loofah` gem.
# Please instead update this file by running `bin/tapioca gem loofah`.


# source://loofah//lib/loofah.rb#5
module Loofah
  class << self
    # source://loofah//lib/loofah.rb#76
    def document(*args, &block); end

    # source://loofah//lib/loofah.rb#83
    def fragment(*args, &block); end

    # source://loofah//lib/loofah.rb#76
    def html4_document(*args, &block); end

    # source://loofah//lib/loofah.rb#83
    def html4_fragment(*args, &block); end

    # source://loofah//lib/loofah.rb#101
    def html5_document(*args, &block); end

    # source://loofah//lib/loofah.rb#108
    def html5_fragment(*args, &block); end

    # source://loofah//lib/loofah.rb#7
    def html5_support?; end

    # source://loofah//lib/loofah.rb#169
    def remove_extraneous_whitespace(string); end

    # source://loofah//lib/loofah.rb#88
    def scrub_document(string_or_io, method); end

    # source://loofah//lib/loofah.rb#93
    def scrub_fragment(string_or_io, method); end

    # source://loofah//lib/loofah.rb#88
    def scrub_html4_document(string_or_io, method); end

    # source://loofah//lib/loofah.rb#93
    def scrub_html4_fragment(string_or_io, method); end

    # source://loofah//lib/loofah.rb#113
    def scrub_html5_document(string_or_io, method); end

    # source://loofah//lib/loofah.rb#118
    def scrub_html5_fragment(string_or_io, method); end

    # source://loofah//lib/loofah.rb#164
    def scrub_xml_document(string_or_io, method); end

    # source://loofah//lib/loofah.rb#159
    def scrub_xml_fragment(string_or_io, method); end

    # source://loofah//lib/loofah.rb#147
    def xml_document(*args, &block); end

    # source://loofah//lib/loofah.rb#154
    def xml_fragment(*args, &block); end
  end
end

# source://loofah//lib/loofah/concerns.rb#125
module Loofah::DocumentDecorator
  # source://loofah//lib/loofah/concerns.rb#126
  def initialize(*args, &block); end
end

# source://loofah//lib/loofah/elements.rb#6
module Loofah::Elements; end

# source://loofah//lib/loofah/elements.rb#93
Loofah::Elements::BLOCK_LEVEL = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#90
Loofah::Elements::INLINE_LINE_BREAK = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#94
Loofah::Elements::LINEBREAKERS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#76
Loofah::Elements::LOOSE_BLOCK_LEVEL = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#92
Loofah::Elements::STRICT_BLOCK_LEVEL = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#7
Loofah::Elements::STRICT_BLOCK_LEVEL_HTML4 = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/elements.rb#35
Loofah::Elements::STRICT_BLOCK_LEVEL_HTML5 = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah.rb#70
Loofah::HTML = Loofah::HTML4

# source://loofah//lib/loofah/html4/document.rb#4
module Loofah::HTML4; end

# source://loofah//lib/loofah/html4/document.rb#10
class Loofah::HTML4::Document < ::Nokogiri::HTML4::Document
  include ::Loofah::ScrubBehavior::Node
  include ::Loofah::DocumentDecorator
  include ::Loofah::TextBehavior
  include ::Loofah::HtmlDocumentBehavior
  extend ::Loofah::HtmlDocumentBehavior::ClassMethods
end

# source://loofah//lib/loofah/html4/document_fragment.rb#10
class Loofah::HTML4::DocumentFragment < ::Nokogiri::HTML4::DocumentFragment
  include ::Loofah::TextBehavior
  include ::Loofah::HtmlFragmentBehavior
  extend ::Loofah::HtmlFragmentBehavior::ClassMethods
end

# source://loofah//lib/loofah/html5/safelist.rb#6
module Loofah::HTML5; end

# source://loofah//lib/loofah/html5/document.rb#10
class Loofah::HTML5::Document < ::Nokogiri::HTML5::Document
  include ::Loofah::ScrubBehavior::Node
  include ::Loofah::DocumentDecorator
  include ::Loofah::TextBehavior
  include ::Loofah::HtmlDocumentBehavior
  extend ::Loofah::HtmlDocumentBehavior::ClassMethods
end

# source://loofah//lib/loofah/html5/document_fragment.rb#10
class Loofah::HTML5::DocumentFragment < ::Nokogiri::HTML5::DocumentFragment
  include ::Loofah::TextBehavior
  include ::Loofah::HtmlFragmentBehavior
  extend ::Loofah::HtmlFragmentBehavior::ClassMethods
end

# source://loofah//lib/loofah/html5/safelist.rb#49
module Loofah::HTML5::SafeList; end

# source://loofah//lib/loofah/html5/safelist.rb#232
Loofah::HTML5::SafeList::ACCEPTABLE_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#738
Loofah::HTML5::SafeList::ACCEPTABLE_CSS_COLORS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#758
Loofah::HTML5::SafeList::ACCEPTABLE_CSS_EXTENDED_COLORS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#910
Loofah::HTML5::SafeList::ACCEPTABLE_CSS_FUNCTIONS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#699
Loofah::HTML5::SafeList::ACCEPTABLE_CSS_KEYWORDS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#626
Loofah::HTML5::SafeList::ACCEPTABLE_CSS_PROPERTIES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#50
Loofah::HTML5::SafeList::ACCEPTABLE_ELEMENTS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#983
Loofah::HTML5::SafeList::ACCEPTABLE_PROTOCOLS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#970
Loofah::HTML5::SafeList::ACCEPTABLE_SVG_PROPERTIES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1014
Loofah::HTML5::SafeList::ACCEPTABLE_URI_DATA_MEDIATYPES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1024
Loofah::HTML5::SafeList::ALLOWED_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1027
Loofah::HTML5::SafeList::ALLOWED_CSS_FUNCTIONS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1026
Loofah::HTML5::SafeList::ALLOWED_CSS_KEYWORDS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1025
Loofah::HTML5::SafeList::ALLOWED_CSS_PROPERTIES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1023
Loofah::HTML5::SafeList::ALLOWED_ELEMENTS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1048
Loofah::HTML5::SafeList::ALLOWED_ELEMENTS_WITH_LIBXML2 = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1029
Loofah::HTML5::SafeList::ALLOWED_PROTOCOLS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1028
Loofah::HTML5::SafeList::ALLOWED_SVG_PROPERTIES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1030
Loofah::HTML5::SafeList::ALLOWED_URI_DATA_MEDIATYPES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#526
Loofah::HTML5::SafeList::ARIA_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#582
Loofah::HTML5::SafeList::ATTR_VAL_IS_URI = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#315
Loofah::HTML5::SafeList::MATHML_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#147
Loofah::HTML5::SafeList::MATHML_ELEMENTS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#981
Loofah::HTML5::SafeList::PROTOCOL_SEPARATOR = T.let(T.unsafe(nil), Regexp)

# source://loofah//lib/loofah/html5/safelist.rb#963
Loofah::HTML5::SafeList::SHORTHAND_CSS_PROPERTIES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#608
Loofah::HTML5::SafeList::SVG_ALLOW_LOCAL_HREF = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#367
Loofah::HTML5::SafeList::SVG_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#594
Loofah::HTML5::SafeList::SVG_ATTR_VAL_ALLOWS_REF = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#183
Loofah::HTML5::SafeList::SVG_ELEMENTS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1043
Loofah::HTML5::SafeList::TAGS_SAFE_WITH_LIBXML2 = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/safelist.rb#1034
Loofah::HTML5::SafeList::VOID_ELEMENTS = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/scrub.rb#8
module Loofah::HTML5::Scrub
  class << self
    # source://loofah//lib/loofah/html5/scrub.rb#18
    def allowed_element?(element_name); end

    # source://loofah//lib/loofah/html5/scrub.rb#192
    def cdata_escape(node); end

    # source://loofah//lib/loofah/html5/scrub.rb#187
    def cdata_needs_escaping?(node); end

    # source://loofah//lib/loofah/html5/scrub.rb#207
    def escape_tags(string); end

    # source://loofah//lib/loofah/html5/scrub.rb#166
    def force_correct_attribute_escaping!(node); end

    # source://loofah//lib/loofah/html5/scrub.rb#123
    def scrub_attribute_that_allows_local_ref(attr_node); end

    # source://loofah//lib/loofah/html5/scrub.rb#23
    def scrub_attributes(node); end

    # source://loofah//lib/loofah/html5/scrub.rb#72
    def scrub_css(style); end

    # source://loofah//lib/loofah/html5/scrub.rb#67
    def scrub_css_attribute(node); end

    # source://loofah//lib/loofah/html5/scrub.rb#142
    def scrub_uri_attribute(attr_node); end
  end
end

# source://loofah//lib/loofah/html5/scrub.rb#9
Loofah::HTML5::Scrub::CONTROL_CHARACTERS = T.let(T.unsafe(nil), Regexp)

# source://loofah//lib/loofah/html5/scrub.rb#11
Loofah::HTML5::Scrub::CRASS_SEMICOLON = T.let(T.unsafe(nil), Hash)

# source://loofah//lib/loofah/html5/scrub.rb#12
Loofah::HTML5::Scrub::CSS_IMPORTANT = T.let(T.unsafe(nil), String)

# source://loofah//lib/loofah/html5/scrub.rb#10
Loofah::HTML5::Scrub::CSS_KEYWORDISH = T.let(T.unsafe(nil), Regexp)

# source://loofah//lib/loofah/html5/scrub.rb#14
Loofah::HTML5::Scrub::CSS_PROPERTY_STRING_WITHOUT_EMBEDDED_QUOTES = T.let(T.unsafe(nil), Regexp)

# source://loofah//lib/loofah/html5/scrub.rb#13
Loofah::HTML5::Scrub::CSS_WHITESPACE = T.let(T.unsafe(nil), String)

# source://loofah//lib/loofah/html5/scrub.rb#15
Loofah::HTML5::Scrub::DATA_ATTRIBUTE_NAME = T.let(T.unsafe(nil), Regexp)

# source://loofah//lib/loofah/html5/safelist.rb#1051
Loofah::HTML5::WhiteList = Loofah::HTML5::SafeList

# source://loofah//lib/loofah/concerns.rb#133
module Loofah::HtmlDocumentBehavior
  mixes_in_class_methods ::Loofah::HtmlDocumentBehavior::ClassMethods

  # source://loofah//lib/loofah/concerns.rb#164
  def serialize_root; end

  class << self
    # source://loofah//lib/loofah/concerns.rb#159
    def included(base); end
  end
end

# source://loofah//lib/loofah/concerns.rb#134
module Loofah::HtmlDocumentBehavior::ClassMethods
  # source://loofah//lib/loofah/concerns.rb#135
  def parse(*args, &block); end

  private

  # source://loofah//lib/loofah/concerns.rb#150
  def remove_comments_before_html_element(doc); end
end

# source://loofah//lib/loofah/concerns.rb#169
module Loofah::HtmlFragmentBehavior
  mixes_in_class_methods ::Loofah::HtmlFragmentBehavior::ClassMethods

  # source://loofah//lib/loofah/concerns.rb#197
  def serialize; end

  # source://loofah//lib/loofah/concerns.rb#203
  def serialize_root; end

  # source://loofah//lib/loofah/concerns.rb#197
  def to_s; end

  class << self
    # source://loofah//lib/loofah/concerns.rb#192
    def included(base); end
  end
end

# source://loofah//lib/loofah/concerns.rb#170
module Loofah::HtmlFragmentBehavior::ClassMethods
  # source://loofah//lib/loofah/concerns.rb#180
  def document_klass; end

  # source://loofah//lib/loofah/concerns.rb#171
  def parse(tags, encoding = T.unsafe(nil)); end
end

# source://loofah//lib/loofah/html5/libxml2_workarounds.rb#12
module Loofah::LibxmlWorkarounds; end

# source://loofah//lib/loofah/html5/libxml2_workarounds.rb#20
Loofah::LibxmlWorkarounds::BROKEN_ESCAPING_ATTRIBUTES = T.let(T.unsafe(nil), Set)

# source://loofah//lib/loofah/html5/libxml2_workarounds.rb#26
Loofah::LibxmlWorkarounds::BROKEN_ESCAPING_ATTRIBUTES_QUALIFYING_TAG = T.let(T.unsafe(nil), Hash)

# source://loofah//lib/loofah/metahelpers.rb#4
module Loofah::MetaHelpers
  class << self
    # source://loofah//lib/loofah/metahelpers.rb#6
    def add_downcased_set_members_to_all_set_constants(mojule); end
  end
end

# source://loofah//lib/loofah/concerns.rb#30
module Loofah::ScrubBehavior
  class << self
    # source://loofah//lib/loofah/concerns.rb#59
    def resolve_scrubber(scrubber); end
  end
end

# source://loofah//lib/loofah/concerns.rb#31
module Loofah::ScrubBehavior::Node
  # source://loofah//lib/loofah/concerns.rb#32
  def scrub!(scrubber); end
end

# source://loofah//lib/loofah/concerns.rb#51
module Loofah::ScrubBehavior::NodeSet
  # source://loofah//lib/loofah/concerns.rb#52
  def scrub!(scrubber); end
end

# source://loofah//lib/loofah/scrubber.rb#35
class Loofah::Scrubber
  # source://loofah//lib/loofah/scrubber.rb#65
  def initialize(options = T.unsafe(nil), &block); end

  # source://loofah//lib/loofah/scrubber.rb#96
  def append_attribute(node, attribute, value); end

  # source://loofah//lib/loofah/scrubber.rb#49
  def block; end

  # source://loofah//lib/loofah/scrubber.rb#44
  def direction; end

  # source://loofah//lib/loofah/scrubber.rb#88
  def scrub(node); end

  # source://loofah//lib/loofah/scrubber.rb#80
  def traverse(node); end

  private

  # source://loofah//lib/loofah/scrubber.rb#105
  def html5lib_sanitize(node); end

  # source://loofah//lib/loofah/scrubber.rb#131
  def traverse_conditionally_bottom_up(node); end

  # source://loofah//lib/loofah/scrubber.rb#122
  def traverse_conditionally_top_down(node); end
end

# source://loofah//lib/loofah/scrubber.rb#37
Loofah::Scrubber::CONTINUE = T.let(T.unsafe(nil), Object)

# source://loofah//lib/loofah/scrubber.rb#40
Loofah::Scrubber::STOP = T.let(T.unsafe(nil), Object)

# source://loofah//lib/loofah/scrubber.rb#7
class Loofah::ScrubberNotFound < ::RuntimeError; end

# source://loofah//lib/loofah/scrubbers.rb#104
module Loofah::Scrubbers
  class << self
    # source://loofah//lib/loofah/scrubbers.rb#425
    def scrubber_symbols; end
  end
end

# source://loofah//lib/loofah/scrubbers.rb#362
class Loofah::Scrubbers::DoubleBreakpoint < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#363
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#367
  def scrub(node); end

  private

  # source://loofah//lib/loofah/scrubbers.rb#400
  def remove_blank_text_nodes(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#159
class Loofah::Scrubbers::Escape < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#160
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#164
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#407
Loofah::Scrubbers::MAP = T.let(T.unsafe(nil), Hash)

# source://loofah//lib/loofah/scrubbers.rb#307
class Loofah::Scrubbers::NewlineBlockElements < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#308
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#312
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#220
class Loofah::Scrubbers::NoFollow < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#221
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#225
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#271
class Loofah::Scrubbers::NoOpener < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#272
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#276
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#293
class Loofah::Scrubbers::NoReferrer < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#294
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#298
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#137
class Loofah::Scrubbers::Prune < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#138
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#142
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#114
class Loofah::Scrubbers::Strip < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#115
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#119
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#246
class Loofah::Scrubbers::TargetBlank < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#247
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#251
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#340
class Loofah::Scrubbers::Unprintable < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#341
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#345
  def scrub(node); end
end

# source://loofah//lib/loofah/scrubbers.rb#191
class Loofah::Scrubbers::Whitewash < ::Loofah::Scrubber
  # source://loofah//lib/loofah/scrubbers.rb#192
  def initialize; end

  # source://loofah//lib/loofah/scrubbers.rb#196
  def scrub(node); end
end

# source://loofah//lib/loofah/concerns.rb#73
module Loofah::TextBehavior
  # source://loofah//lib/loofah/concerns.rb#94
  def inner_text(options = T.unsafe(nil)); end

  # source://loofah//lib/loofah/concerns.rb#94
  def text(options = T.unsafe(nil)); end

  # source://loofah//lib/loofah/concerns.rb#94
  def to_str(options = T.unsafe(nil)); end

  # source://loofah//lib/loofah/concerns.rb#120
  def to_text(options = T.unsafe(nil)); end
end

# source://loofah//lib/loofah/version.rb#5
Loofah::VERSION = T.let(T.unsafe(nil), String)

# source://loofah//lib/loofah/xml/document.rb#4
module Loofah::XML; end

# source://loofah//lib/loofah/xml/document.rb#10
class Loofah::XML::Document < ::Nokogiri::XML::Document
  include ::Loofah::ScrubBehavior::Node
  include ::Loofah::DocumentDecorator
end

# source://loofah//lib/loofah/xml/document_fragment.rb#10
class Loofah::XML::DocumentFragment < ::Nokogiri::XML::DocumentFragment
  class << self
    # source://loofah//lib/loofah/xml/document_fragment.rb#12
    def parse(tags); end
  end
end
