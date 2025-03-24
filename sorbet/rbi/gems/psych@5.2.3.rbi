# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `psych` gem.
# Please instead update this file by running `bin/tapioca gem psych`.


# source://psych//lib/psych/core_ext.rb#2
class Object < ::BasicObject
  include ::Kernel
  include ::PP::ObjectMixin

  # source://psych//lib/psych/core_ext.rb#12
  def to_yaml(options = T.unsafe(nil)); end

  class << self
    # source://psych//lib/psych/core_ext.rb#3
    def yaml_tag(url); end
  end
end

# source://psych//lib/psych/versions.rb#3
module Psych
  class << self
    # source://psych//lib/psych.rb#700
    def add_builtin_type(type_tag, &block); end

    # source://psych//lib/psych.rb#694
    def add_domain_type(domain, type_tag, &block); end

    # source://psych//lib/psych.rb#710
    def add_tag(tag, klass); end

    # source://psych//lib/psych.rb#726
    def config; end

    # source://psych//lib/psych.rb#738
    def domain_types; end

    # source://psych//lib/psych.rb#750
    def domain_types=(value); end

    # source://psych//lib/psych.rb#515
    def dump(o, io = T.unsafe(nil), options = T.unsafe(nil)); end

    # source://psych//lib/psych.rb#613
    def dump_stream(*objects); end

    # source://psych//lib/psych.rb#734
    def dump_tags; end

    # source://psych//lib/psych.rb#746
    def dump_tags=(value); end

    # source://psych//lib/psych.rb#370
    def load(yaml, permitted_classes: T.unsafe(nil), permitted_symbols: T.unsafe(nil), aliases: T.unsafe(nil), filename: T.unsafe(nil), fallback: T.unsafe(nil), symbolize_names: T.unsafe(nil), freeze: T.unsafe(nil), strict_integer: T.unsafe(nil)); end

    # source://psych//lib/psych.rb#687
    def load_file(filename, **kwargs); end

    # source://psych//lib/psych.rb#644
    def load_stream(yaml, filename: T.unsafe(nil), fallback: T.unsafe(nil), **kwargs); end

    # source://psych//lib/psych.rb#730
    def load_tags; end

    # source://psych//lib/psych.rb#742
    def load_tags=(value); end

    # source://psych//lib/psych.rb#400
    def parse(yaml, filename: T.unsafe(nil)); end

    # source://psych//lib/psych.rb#412
    def parse_file(filename, fallback: T.unsafe(nil)); end

    # source://psych//lib/psych.rb#454
    def parse_stream(yaml, filename: T.unsafe(nil), &block); end

    # source://psych//lib/psych.rb#421
    def parser; end

    # source://psych//lib/psych.rb#706
    def remove_type(type_tag); end

    # source://psych//lib/psych.rb#596
    def safe_dump(o, io = T.unsafe(nil), options = T.unsafe(nil)); end

    # source://psych//lib/psych.rb#324
    def safe_load(yaml, permitted_classes: T.unsafe(nil), permitted_symbols: T.unsafe(nil), aliases: T.unsafe(nil), filename: T.unsafe(nil), fallback: T.unsafe(nil), symbolize_names: T.unsafe(nil), freeze: T.unsafe(nil), strict_integer: T.unsafe(nil)); end

    # source://psych//lib/psych.rb#676
    def safe_load_file(filename, **kwargs); end

    # source://psych//lib/psych.rb#623
    def to_json(object); end

    # source://psych//lib/psych.rb#273
    def unsafe_load(yaml, filename: T.unsafe(nil), fallback: T.unsafe(nil), symbolize_names: T.unsafe(nil), freeze: T.unsafe(nil), strict_integer: T.unsafe(nil)); end

    # source://psych//lib/psych.rb#665
    def unsafe_load_file(filename, **kwargs); end
  end
end

# source://psych//lib/psych/exception.rb#10
class Psych::AliasesNotEnabled < ::Psych::BadAlias
  # source://psych//lib/psych/exception.rb#11
  def initialize; end
end

# source://psych//lib/psych/exception.rb#17
class Psych::AnchorNotDefined < ::Psych::BadAlias
  # source://psych//lib/psych/exception.rb#18
  def initialize(anchor_name); end
end

# source://psych//lib/psych/class_loader.rb#6
class Psych::ClassLoader
  # source://psych//lib/psych/class_loader.rb#21
  def initialize; end

  # source://psych//lib/psych/class_loader.rb#39
  def big_decimal; end

  # source://psych//lib/psych/class_loader.rb#39
  def complex; end

  # source://psych//lib/psych/class_loader.rb#39
  def date; end

  # source://psych//lib/psych/class_loader.rb#39
  def date_time; end

  # source://psych//lib/psych/class_loader.rb#39
  def exception; end

  # source://psych//lib/psych/class_loader.rb#25
  def load(klassname); end

  # source://psych//lib/psych/class_loader.rb#39
  def object; end

  # source://psych//lib/psych/class_loader.rb#39
  def psych_omap; end

  # source://psych//lib/psych/class_loader.rb#39
  def psych_set; end

  # source://psych//lib/psych/class_loader.rb#39
  def range; end

  # source://psych//lib/psych/class_loader.rb#39
  def rational; end

  # source://psych//lib/psych/class_loader.rb#39
  def regexp; end

  # source://psych//lib/psych/class_loader.rb#39
  def struct; end

  # source://psych//lib/psych/class_loader.rb#39
  def symbol; end

  # source://psych//lib/psych/class_loader.rb#31
  def symbolize(sym); end

  private

  # source://psych//lib/psych/class_loader.rb#47
  def find(klassname); end

  # source://psych//lib/psych/class_loader.rb#51
  def resolve(klassname); end
end

# source://psych//lib/psych/class_loader.rb#76
class Psych::ClassLoader::Restricted < ::Psych::ClassLoader
  # source://psych//lib/psych/class_loader.rb#77
  def initialize(classes, symbols); end

  # source://psych//lib/psych/class_loader.rb#83
  def symbolize(sym); end

  private

  # source://psych//lib/psych/class_loader.rb#95
  def find(klassname); end
end

# source://psych//lib/psych/coder.rb#9
class Psych::Coder
  # source://psych//lib/psych/coder.rb#13
  def initialize(tag); end

  # source://psych//lib/psych/coder.rb#84
  def [](k); end

  # source://psych//lib/psych/coder.rb#78
  def []=(k, v); end

  # source://psych//lib/psych/coder.rb#78
  def add(k, v); end

  # source://psych//lib/psych/coder.rb#10
  def implicit; end

  # source://psych//lib/psych/coder.rb#10
  def implicit=(_arg0); end

  # source://psych//lib/psych/coder.rb#34
  def map(tag = T.unsafe(nil), style = T.unsafe(nil)); end

  # source://psych//lib/psych/coder.rb#73
  def map=(map); end

  # source://psych//lib/psych/coder.rb#10
  def object; end

  # source://psych//lib/psych/coder.rb#10
  def object=(_arg0); end

  # source://psych//lib/psych/coder.rb#54
  def represent_map(tag, map); end

  # source://psych//lib/psych/coder.rb#60
  def represent_object(tag, obj); end

  # source://psych//lib/psych/coder.rb#42
  def represent_scalar(tag, value); end

  # source://psych//lib/psych/coder.rb#48
  def represent_seq(tag, list); end

  # source://psych//lib/psych/coder.rb#24
  def scalar(*args); end

  # source://psych//lib/psych/coder.rb#67
  def scalar=(value); end

  # source://psych//lib/psych/coder.rb#11
  def seq; end

  # source://psych//lib/psych/coder.rb#90
  def seq=(list); end

  # source://psych//lib/psych/coder.rb#10
  def style; end

  # source://psych//lib/psych/coder.rb#10
  def style=(_arg0); end

  # source://psych//lib/psych/coder.rb#10
  def tag; end

  # source://psych//lib/psych/coder.rb#10
  def tag=(_arg0); end

  # source://psych//lib/psych/coder.rb#11
  def type; end
end

# source://psych//lib/psych/exception.rb#23
class Psych::DisallowedClass < ::Psych::Exception
  # source://psych//lib/psych/exception.rb#24
  def initialize(action, klass_name); end
end

# source://psych//lib/psych/handler.rb#13
class Psych::Handler
  # source://psych//lib/psych/handler.rb#110
  def alias(anchor); end

  # source://psych//lib/psych/handler.rb#236
  def empty; end

  # source://psych//lib/psych/handler.rb#93
  def end_document(implicit); end

  # source://psych//lib/psych/handler.rb#230
  def end_mapping; end

  # source://psych//lib/psych/handler.rb#191
  def end_sequence; end

  # source://psych//lib/psych/handler.rb#241
  def end_stream; end

  # source://psych//lib/psych/handler.rb#246
  def event_location(start_line, start_column, end_line, end_column); end

  # source://psych//lib/psych/handler.rb#150
  def scalar(value, anchor, tag, plain, quoted, style); end

  # source://psych//lib/psych/handler.rb#72
  def start_document(version, tag_directives, implicit); end

  # source://psych//lib/psych/handler.rb#225
  def start_mapping(anchor, tag, implicit, style); end

  # source://psych//lib/psych/handler.rb#186
  def start_sequence(anchor, tag, implicit, style); end

  # source://psych//lib/psych/handler.rb#47
  def start_stream(encoding); end

  # source://psych//lib/psych/handler.rb#251
  def streaming?; end
end

# source://psych//lib/psych/handler.rb#16
class Psych::Handler::DumperOptions
  # source://psych//lib/psych/handler.rb#19
  def initialize; end

  # source://psych//lib/psych/handler.rb#17
  def canonical; end

  # source://psych//lib/psych/handler.rb#17
  def canonical=(_arg0); end

  # source://psych//lib/psych/handler.rb#17
  def indentation; end

  # source://psych//lib/psych/handler.rb#17
  def indentation=(_arg0); end

  # source://psych//lib/psych/handler.rb#17
  def line_width; end

  # source://psych//lib/psych/handler.rb#17
  def line_width=(_arg0); end
end

# source://psych//lib/psych/json/stream.rb#7
class Psych::JSON::Stream < ::Psych::Visitors::JSONTree
  include ::Psych::Streaming
  extend ::Psych::Streaming::ClassMethods
end

# source://psych//lib/psych/parser.rb#33
class Psych::Parser
  # source://psych//lib/psych/parser.rb#47
  def initialize(handler = T.unsafe(nil)); end

  # source://psych//lib/psych/parser.rb#41
  def external_encoding=(_arg0); end

  # source://psych//lib/psych/parser.rb#38
  def handler; end

  # source://psych//lib/psych/parser.rb#38
  def handler=(_arg0); end

  # source://psych//lib/psych/parser.rb#61
  def parse(yaml, path = T.unsafe(nil)); end
end

# source://psych//lib/psych/scalar_scanner.rb#6
class Psych::ScalarScanner
  # source://psych//lib/psych/scalar_scanner.rb#30
  def initialize(class_loader, strict_integer: T.unsafe(nil)); end

  # source://psych//lib/psych/scalar_scanner.rb#27
  def class_loader; end

  # source://psych//lib/psych/scalar_scanner.rb#108
  def parse_int(string); end

  # source://psych//lib/psych/scalar_scanner.rb#114
  def parse_time(string); end

  # source://psych//lib/psych/scalar_scanner.rb#37
  def tokenize(string); end
end

# source://psych//lib/psych/scalar_scanner.rb#22
Psych::ScalarScanner::INTEGER_LEGACY = T.let(T.unsafe(nil), Regexp)

# source://psych//lib/psych/scalar_scanner.rb#15
Psych::ScalarScanner::INTEGER_STRICT = T.let(T.unsafe(nil), Regexp)

# source://psych//lib/psych/stream.rb#24
class Psych::Stream < ::Psych::Visitors::YAMLTree
  include ::Psych::Streaming
  extend ::Psych::Streaming::ClassMethods
end

# source://psych//lib/psych/stream.rb#25
class Psych::Stream::Emitter < ::Psych::Emitter
  # source://psych//lib/psych/stream.rb#26
  def end_document(implicit_end = T.unsafe(nil)); end

  # source://psych//lib/psych/stream.rb#30
  def streaming?; end
end

# source://psych//lib/psych/streaming.rb#3
module Psych::Streaming
  # source://psych//lib/psych/streaming.rb#18
  def start(encoding = T.unsafe(nil)); end

  private

  # source://psych//lib/psych/streaming.rb#25
  def register(target, obj); end
end

# source://psych//lib/psych/streaming.rb#4
module Psych::Streaming::ClassMethods
  # source://psych//lib/psych/streaming.rb#8
  def new(io); end
end

# source://psych//lib/psych/syntax_error.rb#5
class Psych::SyntaxError < ::Psych::Exception
  # source://psych//lib/psych/syntax_error.rb#8
  def initialize(file, line, col, offset, problem, context); end

  # source://psych//lib/psych/syntax_error.rb#6
  def column; end

  # source://psych//lib/psych/syntax_error.rb#6
  def context; end

  # source://psych//lib/psych/syntax_error.rb#6
  def file; end

  # source://psych//lib/psych/syntax_error.rb#6
  def line; end

  # source://psych//lib/psych/syntax_error.rb#6
  def offset; end

  # source://psych//lib/psych/syntax_error.rb#6
  def problem; end
end

# source://psych//lib/psych/tree_builder.rb#17
class Psych::TreeBuilder < ::Psych::Handler
  # source://psych//lib/psych/tree_builder.rb#22
  def initialize; end

  # source://psych//lib/psych/tree_builder.rb#103
  def alias(anchor); end

  # source://psych//lib/psych/tree_builder.rb#77
  def end_document(implicit_end = T.unsafe(nil)); end

  # source://psych//lib/psych/tree_builder.rb#52
  def end_mapping; end

  # source://psych//lib/psych/tree_builder.rb#52
  def end_sequence; end

  # source://psych//lib/psych/tree_builder.rb#90
  def end_stream; end

  # source://psych//lib/psych/tree_builder.rb#33
  def event_location(start_line, start_column, end_line, end_column); end

  # source://psych//lib/psych/tree_builder.rb#19
  def root; end

  # source://psych//lib/psych/tree_builder.rb#96
  def scalar(value, anchor, tag, plain, quoted, style); end

  # source://psych//lib/psych/tree_builder.rb#65
  def start_document(version, tag_directives, implicit); end

  # source://psych//lib/psych/tree_builder.rb#45
  def start_mapping(anchor, tag, implicit, style); end

  # source://psych//lib/psych/tree_builder.rb#45
  def start_sequence(anchor, tag, implicit, style); end

  # source://psych//lib/psych/tree_builder.rb#84
  def start_stream(encoding); end

  private

  # source://psych//lib/psych/tree_builder.rb#116
  def pop; end

  # source://psych//lib/psych/tree_builder.rb#111
  def push(value); end

  # source://psych//lib/psych/tree_builder.rb#132
  def set_end_location(node); end

  # source://psych//lib/psych/tree_builder.rb#122
  def set_location(node); end

  # source://psych//lib/psych/tree_builder.rb#127
  def set_start_location(node); end
end

# source://psych//lib/psych/versions.rb#5
Psych::VERSION = T.let(T.unsafe(nil), String)

# source://psych//lib/psych/visitors/depth_first.rb#4
class Psych::Visitors::DepthFirst < ::Psych::Visitors::Visitor
  # source://psych//lib/psych/visitors/depth_first.rb#5
  def initialize(block); end

  private

  # source://psych//lib/psych/visitors/depth_first.rb#11
  def nary(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#20
  def terminal(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#20
  def visit_Psych_Nodes_Alias(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#11
  def visit_Psych_Nodes_Document(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#11
  def visit_Psych_Nodes_Mapping(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#20
  def visit_Psych_Nodes_Scalar(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#11
  def visit_Psych_Nodes_Sequence(o); end

  # source://psych//lib/psych/visitors/depth_first.rb#11
  def visit_Psych_Nodes_Stream(o); end
end

# source://psych//lib/psych/visitors/yaml_tree.rb#537
class Psych::Visitors::RestrictedYAMLTree < ::Psych::Visitors::YAMLTree
  # source://psych//lib/psych/visitors/yaml_tree.rb#549
  def initialize(emitter, ss, options); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#562
  def accept(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#574
  def visit_Symbol(sym); end
end

# source://psych//lib/psych/visitors/yaml_tree.rb#538
Psych::Visitors::RestrictedYAMLTree::DEFAULT_PERMITTED_CLASSES = T.let(T.unsafe(nil), Hash)

# source://psych//lib/psych/visitors/to_ruby.rb#14
class Psych::Visitors::ToRuby < ::Psych::Visitors::Visitor
  # source://psych//lib/psych/visitors/to_ruby.rb#23
  def initialize(ss, class_loader, symbolize_names: T.unsafe(nil), freeze: T.unsafe(nil)); end

  # source://psych//lib/psych/visitors/to_ruby.rb#34
  def accept(target); end

  # source://psych//lib/psych/visitors/to_ruby.rb#21
  def class_loader; end

  # source://psych//lib/psych/visitors/to_ruby.rb#326
  def visit_Psych_Nodes_Alias(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#318
  def visit_Psych_Nodes_Document(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#164
  def visit_Psych_Nodes_Mapping(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#128
  def visit_Psych_Nodes_Scalar(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#132
  def visit_Psych_Nodes_Sequence(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#322
  def visit_Psych_Nodes_Stream(o); end

  private

  # source://psych//lib/psych/visitors/to_ruby.rb#394
  def deduplicate(key); end

  # source://psych//lib/psych/visitors/to_ruby.rb#51
  def deserialize(o); end

  # source://psych//lib/psych/visitors/to_ruby.rb#411
  def init_with(o, h, node); end

  # source://psych//lib/psych/visitors/to_ruby.rb#403
  def merge_key(hash, key, val); end

  # source://psych//lib/psych/visitors/to_ruby.rb#332
  def register(node, object); end

  # source://psych//lib/psych/visitors/to_ruby.rb#337
  def register_empty(object); end

  # source://psych//lib/psych/visitors/to_ruby.rb#424
  def resolve_class(klassname); end

  # source://psych//lib/psych/visitors/to_ruby.rb#406
  def revive(klass, node); end

  # source://psych//lib/psych/visitors/to_ruby.rb#343
  def revive_hash(hash, o, tagged = T.unsafe(nil)); end

  class << self
    # source://psych//lib/psych/visitors/to_ruby.rb#15
    def create(symbolize_names: T.unsafe(nil), freeze: T.unsafe(nil), strict_integer: T.unsafe(nil)); end
  end
end

# source://psych//lib/psych/visitors/visitor.rb#4
class Psych::Visitors::Visitor
  # source://psych//lib/psych/visitors/visitor.rb#5
  def accept(target); end

  private

  # source://psych//lib/psych/visitors/visitor.rb#19
  def dispatch; end

  # source://psych//lib/psych/visitors/visitor.rb#29
  def visit(target); end

  class << self
    # source://psych//lib/psych/visitors/visitor.rb#12
    def dispatch_cache; end
  end
end

# source://psych//lib/psych/visitors/yaml_tree.rb#15
class Psych::Visitors::YAMLTree < ::Psych::Visitors::Visitor
  # source://psych//lib/psych/visitors/yaml_tree.rb#51
  def initialize(emitter, ss, options); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#99
  def <<(object); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#119
  def accept(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#88
  def finish; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#40
  def finished; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#40
  def finished?; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#99
  def push(object); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#82
  def start(encoding = T.unsafe(nil)); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#40
  def started; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#40
  def started?; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#94
  def tree; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#347
  def visit_Array(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#373
  def visit_BasicObject(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#247
  def visit_BigDecimal(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#310
  def visit_Class(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#220
  def visit_Complex(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#191
  def visit_Date(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#195
  def visit_DateTime(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#149
  def visit_Delegator(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#144
  def visit_Encoding(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#355
  def visit_Enumerator(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#179
  def visit_Exception(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#230
  def visit_FalseClass(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#236
  def visit_Float(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#323
  def visit_Hash(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#230
  def visit_Integer(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#305
  def visit_Module(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#183
  def visit_NameError(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#361
  def visit_NilClass(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#149
  def visit_Object(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#136
  def visit_Psych_Omap(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#336
  def visit_Psych_Set(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#315
  def visit_Range(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#207
  def visit_Rational(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#187
  def visit_Regexp(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#251
  def visit_String(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#165
  def visit_Struct(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#365
  def visit_Symbol(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#202
  def visit_Time(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#230
  def visit_TrueClass(o); end

  private

  # source://psych//lib/psych/visitors/yaml_tree.rb#387
  def binary?(string); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#494
  def dump_coder(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#463
  def dump_exception(o, msg); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#529
  def dump_ivars(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#460
  def dump_list(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#507
  def emit_coder(c, o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#481
  def format_time(time, utc = T.unsafe(nil)); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#489
  def register(target, yaml_obj); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#391
  def visit_array_subclass(o); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#422
  def visit_hash_subclass(o); end

  class << self
    # source://psych//lib/psych/visitors/yaml_tree.rb#44
    def create(options = T.unsafe(nil), emitter = T.unsafe(nil)); end
  end
end

# source://psych//lib/psych/visitors/yaml_tree.rb#16
class Psych::Visitors::YAMLTree::Registrar
  # source://psych//lib/psych/visitors/yaml_tree.rb#17
  def initialize; end

  # source://psych//lib/psych/visitors/yaml_tree.rb#31
  def id_for(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#27
  def key?(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#35
  def node_for(target); end

  # source://psych//lib/psych/visitors/yaml_tree.rb#23
  def register(target, node); end
end
