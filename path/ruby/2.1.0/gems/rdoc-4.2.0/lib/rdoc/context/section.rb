##
# A section of documentation like:
#
#   # :section: The title
#   # The body
#
# Sections can be referenced multiple times and will be collapsed into a
# single section.

class RDoc::Context::Section

  include RDoc::Text

  MARSHAL_VERSION = 0 # :nodoc:

  ##
  # Section comments

  attr_reader :comment

  ##
  # Section comments

  attr_reader :comments

  ##
  # Context this Section lives in

  attr_reader :parent

  ##
  # Section title

  attr_reader :title

  @@sequence = "SEC00000"

  ##
  # Creates a new section with +title+ and +comments+

  def initialize parent, title, comment
    @parent = parent
    @title = title ? title.strip : title

    @@sequence.succ!
    @sequence = @@sequence.dup

    @comments = []

    add_comment comment
  end

  ##
  # Sections are equal when they have the same #title

  def == other
    self.class === other and @title == other.title
  end

  ##
  # Adds +comments+ to this section

  def add_comment comment
    comment = extract_comment comment

    return if comment.empty?

    case comment
    when RDoc::Comment then
      @comments << comment
    when RDoc::Markup::Document then
      @comments.concat comment.parts
    when Array then
      @comments.concat comment
    else
      raise TypeError, "unknown comments type: #{comment.inspect}"
    end
  end

  ##
  # Anchor reference for linking to this section

  def aref
    title = @title || '[untitled]'

    CGI.escape(title).gsub('%', '-').sub(/^-/, '')
  end

  ##
  # Extracts the comments for this section from the original comments block.
  # If the first line contains :section:, strip it and use the rest.
  # Otherwise remove lines up to the line containing :section:, and look
  # for those lines again at the end and remove them. This lets us write
  #
  #   # :section: The title
  #   # The body

  def extract_comment comment
    case comment
    when Array then
      comment.map do |c|
        extract_comment c
      end
    when nil
      RDoc::Comment.new ''
    when RDoc::Comment then
      if comment.text =~ /^#[ \t]*:section:.*\n/ then
        start = $`
        rest = $'

        comment.text = if start.empty? then
                         rest
                       else
                         rest.sub(/#{start.chomp}\Z/, '')
                       end
      end

      comment
    when RDoc::Markup::Document then
      comment
    else
      raise TypeError, "unknown comments #{comment.inspect}"
    end
  end

  def inspect # :nodoc:
    "#<%s:0x%x %p>" % [self.class, object_id, title]
  end

  ##
  # The files comments in this section come from

  def in_files
    return [] if @comments.empty?

    case @comments
    when Array then
      @comments.map do |comment|
        comment.file
      end
    when RDoc::Markup::Document then
      @comment.parts.map do |document|
        document.file
      end
    else
      raise RDoc::Error, "BUG: unknown comments class #{@comments.class}"
    end
  end

  ##
  # Serializes this Section.  The title and parsed comments are saved, but not
  # the section parent which must be restored manually.

  def marshal_dump
    [
      MARSHAL_VERSION,
      @title,
      parse,
    ]
  end

  ##
  # De-serializes this Section.  The section parent must be restored manually.

  def marshal_load array
    @parent  = nil

    @title    = array[1]
    @comments = array[2]
  end

  ##
  # Parses +comment_location+ into an RDoc::Markup::Document composed of
  # multiple RDoc::Markup::Documents with their file set.

  def parse
    case @comments
    when String then
      super
    when Array then
      docs = @comments.map do |comment, location|
        doc = super comment
        doc.file = location if location
        doc
      end

      RDoc::Markup::Document.new(*docs)
    when RDoc::Comment then
      doc = super @comments.text, comments.format
      doc.file = @comments.location
      doc
    when RDoc::Markup::Document then
      return @comments
    else
      raise ArgumentError, "unknown comments class #{comments.class}"
    end
  end

  ##
  # The section's title, or 'Top Section' if the title is nil.
  #
  # This is used by the table of contents template so the name is silly.

  def plain_html
    @title || 'Top Section'
  end

  ##
  # Removes a comments from this section if it is from the same file as
  # +comments+

  def remove_comment comment
    return if @comments.empty?

    case @comments
    when Array then
      @comments.delete_if do |my_comment|
        my_comment.file == comment.file
      end
    when RDoc::Markup::Document then
      @comments.parts.delete_if do |document|
        document.file == comment.file.name
      end
    else
      raise RDoc::Error, "BUG: unknown comments class #{@comments.class}"
    end
  end

  ##
  # Section sequence number (deprecated)

  def sequence
    warn "RDoc::Context::Section#sequence is deprecated, use #aref"
    @sequence
  end

end

