module CsvBase
  module CsvBase
    BOM = "\377\376".force_encoding('UTF-16LE')

    include Enumerable

    def each
      bom, enc = encoding_details
      yield bom unless bom.nil?
      yield encoded(header, enc)

      generate_csv do |row|
        yield encoded(row, enc)
      end
    end

    def encoding
      raise "Implement #encoding in your subclass"
    end

    def header
      ''
    end

    def bom
      ::CsvBase::CsvBase::BOM
    end

    private

    def encoding_details
      case encoding && encoding.downcase.gsub('-', '').to_sym
      when :utf8
        [nil, 'UTF-8']
      when :utf16le
        [BOM, 'UTF-16LE']
      else
        raise ArgumentError, "Unknown encoding #{encoding.inspect}"
      end
    end

    def encoded(string, enc)
      string.encode(enc, undef: :replace)
    end

    # WARNING: This will most likely NOT work on jruby!!!
    def generate_csv
      conn = ActiveRecord::Base.connection.raw_connection
      conn.copy_data(export_csv_query) do
        while row = conn.get_copy_data
          yield row.force_encoding('UTF-8')
        end
      end
    end

    def export_csv_query
      %Q{copy (#{export_sql}) to stdout with (FORMAT CSV, DELIMITER '\t', HEADER FALSE, ENCODING 'UTF-8');}
    end
  end
end
